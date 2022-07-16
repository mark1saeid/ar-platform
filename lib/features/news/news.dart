import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/core/generalwidget/loader_widget.dart';
import 'package:ratering_gen_zero/core/generalwidget/rounded_hotspot_widget.dart';
import 'package:ratering_gen_zero/features/news/service/news_service.dart';

import 'model/news_model.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key key}) : super(key: key);
  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<News>(
      future: getNews(),
      builder: (ctx, snp) {
        switch (snp.connectionState) {
          case ConnectionState.waiting:
            return Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.3),
                child: RoundedHotSpotWidget(widget: LoaderWidget()));
          default:
            if (snp.hasError)
              return Icon(
                Icons.error,
                color: Colors.white,
              );
            else
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  int number = random(0, snp.data.articles.length);
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RoundedHotSpotWidget(
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(ctx).size.width,
                            height: MediaQuery.of(ctx).size.height * 0.14,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      snp.data.articles[number].urlToImage)),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${snp.data.articles[number].title}",
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 2,
              );
        }
      },
    );
  }
}
