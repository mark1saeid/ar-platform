import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panorama/panorama.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/core/generalwidget/hotspot_widget.dart';
import 'package:ratering_gen_zero/core/generalwidget/rounded_hotspot_widget.dart';
import 'package:ratering_gen_zero/core/router/route_center.dart';
import 'package:ratering_gen_zero/core/router/route_left.dart';
import 'package:ratering_gen_zero/core/router/route_right.dart';
import 'package:ratering_gen_zero/features/chat/general_widget/income_call_widget.dart';
import 'package:ratering_gen_zero/features/news/news.dart';
import 'package:ratering_gen_zero/features/weather/model/weather_model.dart';

import '../../keyboard/keyboard.dart';
import '../../news/model/news_model.dart';
import '../../news/service/news_service.dart';
import '../../weather/weather.dart';

class PanoramaWidget extends StatefulWidget {
  const PanoramaWidget({Key key}) : super(key: key);

  @override
  State<PanoramaWidget> createState() => _PanoramaWidgetState();
}

class _PanoramaWidgetState extends State<PanoramaWidget> {
  double _long = 0;
  double _latit = 0;

  String getDate() {
    return DateFormat.jm().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    getNews();

    log("PanoramaWidget");
    return Panorama(
      zoom: 0,
      interactive: false,
      animSpeed: 0.01,
      //    minLongitude :-50 ,
      //  maxLongitude: 50,
      croppedArea: const Rect.fromLTWH(0.0, 0.0, 0.0, 0.0),
      croppedFullWidth: 0,
      croppedFullHeight: 0,
      sensorControl: SensorControl.Orientation,
      onTap: (longitude, latitude, tilt) =>
          print('onTap: $longitude, $latitude, $tilt'),
      onLongPressMoveUpdate: (longitude, latitude, tilt) =>
          print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
      onLongPressEnd: (longitude, latitude, tilt) =>
          print('onLongPressEnd: $longitude, $latitude, $tilt'),
      hotspots: [
        Hotspot(
          latitude: -80 + _latit,
          longitude: 0 + _long,
          width: 400.0,
          height: 100.0,
          widget: Text(
            "You Can Check ADs Here",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Hotspot(
          latitude: 0 + _latit,
          longitude: 0 + _long,
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          widget: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: RoundedHotSpotWidget(
                  widget: Text(
                    "Hello Mark !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: RoundedHotSpotWidget(
                  widget: Consumer<RouterCenter>(
                    builder: (BuildContext context, value, Widget child) =>
                    value.centerScreen,
                  ),
                ),
              ),
            ],
          ),
        ),
        // consumer {by ahmed}
        Hotspot(
            latitude: 0 + _latit,
            longitude: 35 + _long,
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.7,
            widget: Column(
              children: [
               
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: RoundedHotSpotWidget(
                    widget:Text (getDate(),
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: RoundedHotSpotWidget(
                    widget: Consumer<RouterRight>(
                      builder: (BuildContext context, value, Widget child) =>
                      value.rightScreen,
                    ),
                  ),
                ),
              ],
            )),

        Hotspot(
          latitude: 0 + _latit,
          longitude: -35 + _long,
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          widget: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: RoundedHotSpotWidget(
                  widget: Text(
                    "Notification",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Consumer<RouterLeft>(
                  builder: (BuildContext context, value, Widget child) =>
                  value.leftScreen,
                ),
              ),
            ],
          ),
        ),
        Hotspot(
          // keyboard
          latitude: -60 + _latit,
          longitude: 0 + _long,
          width: 370,
          height: 200,
          widget: Keyboard(),
        ),

        Hotspot(
          latitude: 0 + _latit,
          longitude: -70 + _long,
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          widget: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: RoundedHotSpotWidget(widget: WeatherWidget())),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: NewsWidget())
            ],
          ),
        ),
      ],
    );
  }
}
