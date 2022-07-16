import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/features/freinds/viewmodel/tab_bar_provider.dart';

class TabBarScreen extends StatelessWidget {
  static const String id = 'TabBarScreen';

  @override
  Widget build(BuildContext context) {
    return Consumer<TabBarProvider>(
        builder: (BuildContext context, value, Widget child) {
      return DefaultTabController(
        animationDuration: Duration(milliseconds: 500),
        initialIndex: value.currentIndex,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: MediaQuery.of(context).size.height*0.06,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black,
                )),
            elevation: 5,
            backgroundColor: Colors.white,
            title: Text(
              value.titles[value.currentIndex],
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            bottom: TabBar(
              labelPadding: EdgeInsets.zero,
              // indicator: ,
              automaticIndicatorColorAdjustment:true ,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              padding: EdgeInsets.zero,
              unselectedLabelColor: Colors.black54,

              onTap: (index) {
                value.onChange(index);
              },
              tabs: value.appBarList,
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: value.body,
            ),
          ),
        ),
      );
    });
  }
}
