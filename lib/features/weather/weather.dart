import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/core/generalwidget/loader_widget.dart';
import 'package:ratering_gen_zero/features/weather/model/weather_model.dart';
import 'package:ratering_gen_zero/features/weather/service/weather_service.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Whether>(
      future: getWhether(),
      builder: (ctx, snp) {
        switch (snp.connectionState) {
          case ConnectionState.waiting:
            return LoaderWidget();
          default:
            if (snp.hasError)
              return Icon(
                Icons.error,
                color: Colors.white,
              );
            else
              return SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${snp.data.currentConditions?.comment??""}",
                            style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        snp.data.currentConditions?.iconURL??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE1uakm5twZPB9VkT7r7yxvXOWz7Wmqfwkzw&usqp=CAU")),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            Center(
                              child: Text(
                                "${snp.data.currentConditions?.temp?.c??"34"} °C",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Humidity :${snp.data.currentConditions?.humidity??"20%"}",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 12,     fontWeight: FontWeight.bold)),
                            Text(
                                "Wind : ${snp.data.currentConditions?.wind?.km??"14"} Km/H",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
        }
      },
    );
  }
}
