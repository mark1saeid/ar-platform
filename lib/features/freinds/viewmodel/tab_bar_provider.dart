import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/features/freinds/view/add_friends_page/add_friends.dart';
import 'package:ratering_gen_zero/features/freinds/view/upcoming_freinds_page/upcoming_freinds.dart';

class TabBarProvider extends ChangeNotifier {
  int currentIndex = 0;

  onChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Tab> appBarList = [
    Tab(child: Icon(Icons.upcoming)),
    Tab(child: Icon(Icons.person_add_alt)),
  ];

  List<String> titles = [
    'Friends Request',
    'Add Friends',
  ];

  List<Widget> body = [
    UpcomingFriendsScreen(),
    AddNewFriendScreen(),
  ];
}
