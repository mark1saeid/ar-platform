import 'dart:developer';
import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/core/hands/hands_painter.dart';
import 'package:ratering_gen_zero/core/hands/hands_service.dart';
import 'package:ratering_gen_zero/core/utils/isolate_utils.dart';

class CameraHandsWidget extends StatefulWidget {
  CameraHandsWidget({Key key}) : super(key: key);

  @override
  State<CameraHandsWidget> createState() => _CameraHandsWidgetState();
}

class _CameraHandsWidgetState extends State<CameraHandsWidget> {
  CameraController cameraController;
  IsolateUtils isolateUtils;
  Size screenSize;
  int selectedCameraIndex;
  Hands hands;
  double ratio;
  List<Offset> _handLandmarks;
  Offset center;
  bool predicting = false;

  Future initCamera(CameraDescription cameraDescription) async {
    log("initCamerahand");
 /*   if (cameraController != null) {
      await cameraController.dispose();
    }*/

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.ultraHigh);

    cameraController.addListener(() {
      /* if (mounted) {
        //  setState(() {});
      }*/
    });

    if (cameraController.value.hasError) {
      print('Camera Error ${cameraController.value.errorDescription}');
    }

    try {
      isolateUtils = IsolateUtils();
      await isolateUtils.initIsolate();
      hands = Hands();

      await cameraController.initialize().then((value) async {
        if (!mounted) return;
        await cameraController.startImageStream(onLatestImageAvailable);
      });
      // await cameraBytesToDetector(camera: cameraController);
    } catch (e) {
      String errorText = 'Error ${e.code} \nError message: ${e.description}';
      print(errorText);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onLatestImageAvailable(CameraImage cameraImage) async {
    await _inference(
      model: hands,
      handler: runHandDetector,
      cameraImage: cameraImage,
    );
  }

  // todo make provider here and test
  Future<void> _inference({
    dynamic model,
    Function handler,
    CameraImage cameraImage,
  }) async {
    if (model.interpreter != null) {
      if (!predicting) {



      setState(() {
        predicting = true;
      });

      final params = {
        'cameraImage': cameraImage,
        'detectorAddress': model.getAddress,
      };

      final inferenceResults = await _sendPort(
        handler: handler,
        params: params,
      );

      _handLandmarks =
          inferenceResults == null ? null : inferenceResults['point'];

      setState(() {
        predicting = false;
      }); }
    }
  }
  int gestureNumber = 0;
  Future<Map<String, dynamic>> _sendPort({
    Function handler,
    Map<String, dynamic> params,
  }) async {
    final responsePort = ReceivePort();

    isolateUtils.sendMessage(
      handler: handler,
      params: params,
      sendPort: isolateUtils.sendPort,
      responsePort: responsePort,
    );

    final results = await responsePort.first;
    if (results != null) {
      gestureNumber = 0;
      ///Swipe UP
      if (results["point"][5] < results["point"][8] &&
          (results["point"][5] - results["point"][8]).distance > 100) {
        gestureNumber = 2;
        print("Swipe up");
        var position = results["point"][8];
        GestureBinding.instance.handlePointerEvent(PointerScrollEvent(
          position: position,
          kind: PointerDeviceKind.touch,
          scrollDelta: Offset(0, 20),
        ));
      }

      ///Swipe Down
      if (results["point"][5] > results["point"][8] &&
          (results["point"][5] - results["point"][8]).distance > 100) {
        print("Swipe Down");
        gestureNumber = 3;
        var position = results["point"][8];
        GestureBinding.instance.handlePointerEvent(PointerScrollEvent(
          position: position,
          kind: PointerDeviceKind.touch,
          scrollDelta: Offset(0, -20),
        ));
      }

      ///CLICK LOGIC
      if ((results["point"][4] - results["point"][8]).distance < 35) {
        gestureNumber = 1;
        center = Offset((results["point"][4].dx + results["point"][8].dx) / 2,
            (results["point"][4].dy + results["point"][8].dy) / 2);
        GestureBinding.instance
            .handlePointerEvent(PointerDownEvent(position: center));
        GestureBinding.instance
            .handlePointerEvent(PointerUpEvent(position: center));
      }
    }
    responsePort.close();

    return results;
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      initCamera(value[0]).then((value) {});
    }).catchError((e) {
      print('Error : ${e.code}');
    });

    predicting = false;
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    ratio = screenSize.width / screenSize.height;
    return Stack(
      children: [cameraPreview(), drawHand()],
    );
  }

  Widget drawHands() {
    if (_handLandmarks == null) {
      return Container();
    } else {
      return CustomPaint(
        painter: HandsPainter(
          points: _handLandmarks,
          ratio: ratio,
        ),
      );
    }
  }

  Widget drawHand() {
    if (_handLandmarks == null) {
      return Center(
          child: Opacity(
        opacity: 0.3,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.gesture_rounded,
                color: Colors.red,
              ),
            )),
      ));
    } else {
      IconData icon  = Icons.gesture_rounded;
      switch(gestureNumber){
        case 0:
          icon  = Icons.gesture_rounded;
         break;
        case 1:
          icon  = Icons.mouse;
          break;
        case 2:
          icon  = Icons.arrow_downward_rounded;
          break;
        case 3:
          icon  = Icons.arrow_upward_rounded;
          break;
        case 4:
          icon  = Icons.arrow_back_rounded;
          break;
        case 5:
          icon  = Icons.arrow_forward_rounded;
          break;
      }

      return Center(
          child: Opacity(
        opacity: 0.6,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
               icon,
                size: 50,
                color: Colors.green,
              ),
            )),
      ));
    }
  }

  Widget drawPointer() {
    if (center == null) {
      return Container();
    } else {
      return CustomPaint(
        painter: HandsPainter(
          points: [center],
          ratio: ratio,
        ),
      );
    }
  }

  Widget cameraPreview() {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    }
    cameraController.setFocusMode(FocusMode.auto);
    cameraController.setFlashMode(FlashMode.auto);
    final size = MediaQuery.of(context).size;

    var scale = size.aspectRatio * cameraController.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
        scale: scale,
        child: Center(
          child: CameraPreview(cameraController),
        ));
  }
}
