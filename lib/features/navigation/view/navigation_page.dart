import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import 'package:ratering_gen_zero/features/auth/view/profile/profile_page.dart';
import 'package:ratering_gen_zero/features/freinds/constant.dart';
import 'package:ratering_gen_zero/features/freinds/view/tapbar_page/tapbar_page.dart';
import 'package:ratering_gen_zero/features/home/view/main_page.dart';
import 'package:ratering_gen_zero/features/navigation/genral_widget/big_container.dart';
import '../../../core/shared_preferences.dart';
import '../genral_widget/small_container.dart';

class NavigationScreen extends StatefulWidget {
  static const String id = 'NavigationScreen';

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    log("LOGOUT");
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor('#1a2228'),
      body: SafeArea(
        child:
                   SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          buildBigContainer(
                            context: context,
                            text: 'What is',
                            text2: 'Next !',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, MainScreen.id);
                            },
                            child: buildNavigationContainer(
                              icon: Icons.home_outlined,
                              text: 'Home',
                              text2: 'Go to Home Now',
                              context: context,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, EditProfileScreen.id);
                            },
                            child: buildNavigationContainer(
                                icon: Icons.edit_outlined,
                                text: 'Edit',
                                text2: 'Edit your profile now',
                                context: context),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, TabBarScreen.id);
                            },
                            child: buildNavigationContainer(
                                icon: Icons.person_outline_outlined,
                                text: 'Freinds',
                                text2: 'Add or Accept freinds now',
                                context: context),
                          ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () async {

                                },
                                child: buildNavigationContainer(
                                  icon: Icons.settings,
                                  text: 'Settings',
                                  text2: 'edit preference',
                                  context: context,
                                ),
                              ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              await _signOut();
                              CashLogin.removeData(key: 'uId');
                              SystemNavigator.pop();
                            },
                            child: buildNavigationContainer(
                              icon: Icons.login_outlined,
                              text: 'Log Out',
                              text2: 'exit from app',
                              context: context,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ]),
                      ),
                    )
             
            
      ),
    );
  }
}
