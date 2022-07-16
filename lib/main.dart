import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/core/router/route_center.dart';
import 'package:ratering_gen_zero/core/router/route_left.dart';
import 'package:ratering_gen_zero/core/router/route_right.dart';
import 'package:ratering_gen_zero/features/auth/view/forget_password/forget_password.dart';
import 'package:ratering_gen_zero/features/auth/view/login/loginPage.dart';
import 'package:ratering_gen_zero/features/auth/view/register/register_page.dart';
import 'package:ratering_gen_zero/features/auth/view/wellcome/welcomePage.dart';
import 'package:ratering_gen_zero/features/auth/view_model/edt_profile_provider.dart';
import 'package:ratering_gen_zero/features/auth/view_model/login_provider.dart';
import 'package:ratering_gen_zero/features/auth/view_model/signup_provider.dart';
import 'package:ratering_gen_zero/features/chat/view/chat_details_page/chat_detail_page.dart';
import 'package:ratering_gen_zero/features/chat/view/voice_call_page/voice_call_page.dart';
import 'package:ratering_gen_zero/features/freinds/constant.dart';
import 'package:ratering_gen_zero/features/freinds/viewmodel/add_friend_provider.dart';
import 'package:ratering_gen_zero/features/freinds/viewmodel/tab_bar_provider.dart';

import 'package:ratering_gen_zero/features/home/provider/game_provider.dart';
import 'package:ratering_gen_zero/features/home/view/main_page.dart';
import 'package:ratering_gen_zero/features/keyboard/provider/keyboard_provider.dart';
import 'package:ratering_gen_zero/features/navigation/view/navigation_page.dart';
import 'package:wakelock/wakelock.dart';
import 'core/shared_preferences.dart';
import 'features/acitve_user/view/active_userr_page/active_user_page.dart';
import 'features/auth/view/edit_profile/profile_page.dart';
import 'features/freinds/view/add_friends_page/add_friends.dart';
import 'features/freinds/view/tapbar_page/tapbar_page.dart';
import 'features/freinds/view/upcoming_freinds_page/upcoming_freinds.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  Wakelock.enable();
  await CashLogin.init();
  var getId = await CashLogin.getData(key: 'uId');
  print("Get id: ${getId.toString()}");
  Widget startWidget;
  if (getId != null) {
    startWidget = NavigationScreen();
    myId = getId;
  } else {
    startWidget = WelcomePage();
  }

  runApp(
    MultiProvider(
      providers: [
        // LoginProvider
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => KeyboardProvider(),
        ),
        // SignUpProvider
        ChangeNotifierProvider(
          create: (_) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddFriendProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TabBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EditProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GameProvider(),
        ),
        // Navigator
        ChangeNotifierProvider(
          create: (_) => RouterCenter(),
        ),

        ChangeNotifierProvider(
          create: (_) => RouterRight(),
        ),
        ChangeNotifierProvider(
          create: (_) => RouterLeft(),
        ),
      ],
      child: MyApp(startWidget: startWidget),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AR PLATFORM',
      theme: ThemeData(
        // primarySwatch: Colors.black,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ForgetPasswordPage.id: (context) => ForgetPasswordPage(),
        MainScreen.id: (context) => MainScreen(),
        ChatDetailPage.id: (context) => ChatDetailPage(),
        VoiceCallPage().id: (context) => VoiceCallPage(),
        EditProfileScreen.id: (context) => EditProfileScreen(),
        UpcomingFriendsScreen.id: (context) => UpcomingFriendsScreen(),
        AddNewFriendScreen.id: (context) => AddNewFriendScreen(),
        ActiveUserScreen.id: (context) => ActiveUserScreen(),
        TabBarScreen.id: (context) => TabBarScreen(),
        NavigationScreen.id: (context) => NavigationScreen(),
      },
      home: startWidget,
    );
  }
}
