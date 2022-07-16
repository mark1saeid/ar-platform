import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/features/home/view/main_page.dart';


import '../../general_widget/authwidget.dart';
import '../../general_widget/bezierContainer.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const String id = 'ForgetPasswordPage';
  ForgetPasswordPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  const TitleAr(),
                  const SizedBox(height: 130),
                  EntryField(
                    title: "New Password",
                    isPassword: true,
                    hint: "Adokw@m%^_a",
                  ),
                  const SizedBox(height: 20),
                  SubmitButton(
                    title: "confirm",
                    onTap: () async {
                     

                      Navigator.pushNamed(context, MainScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
          const Positioned(top: 40, left: 0, child: BackButton()),
        ],
      ),
    ));
  }
}
