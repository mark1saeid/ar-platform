import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatefulWidget {
  final CameraController cameraController;
  CameraPreviewWidget({Key key, this.cameraController}) : super(key: key);

  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    log("CameraPreviewWidget");
    if (widget.cameraController == null || !widget.cameraController.value.isInitialized) {
      return Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    }
    widget.cameraController.setFocusMode(FocusMode.auto);
    widget.cameraController.setFlashMode(FlashMode.auto);
    final size = MediaQuery.of(context).size;

    var scale = size.aspectRatio * widget.cameraController.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(widget.cameraController),
      ),
    );
  }
}
