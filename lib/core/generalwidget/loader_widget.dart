import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 35,
      width: 35,
      child: LoadingIndicator(
      indicatorType: Indicator.ballClipRotateMultiple, /// Required, The loading type of the widget
      colors: const [Colors.white],       /// Optional, The color collections
      strokeWidth: 5,                     /// Optional, The stroke of the line, only applicable to widget which contains line
      backgroundColor: Colors.transparent,      /// Optional, Background of the widget
      pathBackgroundColor: Colors.transparent   /// Optional, the stroke backgroundColor

          ),
    );
  }
}