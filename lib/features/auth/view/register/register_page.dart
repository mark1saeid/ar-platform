import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/features/auth/general_widget/bezierContainer.dart';
import 'package:ratering_gen_zero/features/auth/services/sign_up_services.dart';
import 'package:ratering_gen_zero/features/navigation/view/navigation_page.dart';
import '../../general_widget/authwidget.dart';
import '../../view_model/signup_provider.dart';
import '../login/loginPage.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'SignUpPage';

  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      const TitleAr(),
                      const SizedBox(
                        height: 50,
                      ),
                      EntryField(
                        validator: (String value) {
                          if (value.trim() == "") {
                            return 'username must not be empty';
                          } else if (value.length < 5) {
                            return 'username must be at least 5 characters';
                          }
                        },
                        controller: userNameController,
                        title: "Username",
                        hint: "example123",
                        isPassword: false,
                      ),
                      EntryField(
                        validator: (String value) {
                          if (value.trim() == "") {
                            return 'Email must not be empty';
                          } else if (!value.contains("@") ||
                              !value.contains(".")) {
                            return 'Email must be a valid email';
                          }
                        },
                        controller: emailController,
                        title: "Email",
                        isPassword: false,
                        hint: "example@gmail.com",
                      ),
                      EntryField(
                          validator: (String value) {
                            if (value.length < 6) {
                              return 'password is too short';
                            }
                          },
                          controller: passwordController,
                          title: "Password",
                          hint: "Adokw@m%^_a",
                          isPassword: true),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<SignUpProvider>(
                          builder: (BuildContext ctx, value, Widget child) {
                        return SubmitButton(
                            title: 'Register Now',
                            onTap: () async{
                              log(emailController.text.toString());
                              log(passwordController.text.toString());
                              log(userNameController.text.toString());
                              if (formKey.currentState.validate()) {
                                log("valid");
                                SignUpServices().signUpSubmit(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  userName: userNameController.text,
                                ).then((value) => Navigator.pushNamed(context, NavigationScreen.id));
                                

                              }
                            });
                      }),
                      SizedBox(height: height * .022),
                      AccountLabel(
                        title: 'Already have an account ?',
                        subtitle: 'Login',
                        //!
                        onTap: () => Navigator.pushNamed(context, LoginPage.id),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(top: 40, left: 0, child: BackButton()),
          ],
        ),
      ),
    );
  }
}
