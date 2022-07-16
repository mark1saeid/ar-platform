import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/features/auth/general_widget/authwidget.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import 'package:ratering_gen_zero/features/auth/view/profile/profile_page.dart';
import 'package:ratering_gen_zero/features/auth/view/register/register_page.dart';
import 'package:ratering_gen_zero/features/auth/view/register/register_page.dart';
import 'package:ratering_gen_zero/features/navigation/view/navigation_page.dart';
import 'package:scidart/numdart.dart';
import '../../../../core/shared_preferences.dart';
import '../../../freinds/constant.dart';
import '../../general_widget/bezierContainer.dart';
import '../../services/login_services.dart';
import '../../view_model/login_provider.dart';
import '../forget_password/forget_password.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'LoginPage';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
        body: SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer()),
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
                    const SizedBox(height: 50),
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
                      isPassword: true,
                      hint: "Adokw@m%^_a",
                    ),
                    const SizedBox(height: 20),
                    Consumer<LoginProvider>(
                      builder:
                          ((BuildContext buildContext, value, Widget child) {
                        return SubmitButton(
                          title: "Login",
                          onTap: () async {


                                if (formKey.currentState.validate()) {
                                  print("startlogin");
                                  loginProvider.loginSubmit(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  if (value.loginSucess){
                                    print("loggen");
                                    
                                    Navigator.pushNamed(
                                        context, NavigationScreen.id);}
                                }



                          },
                        );
                      }),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ForgetPasswordPage.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: const Text('Forgot Password ?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    SizedBox(height: height * .055),
                    AccountLabel(
                      title: 'Don\'t have an account ?',
                      subtitle: 'Register',
                      onTap: () {
                        //!
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(top: 40, left: 0, child: BackButton()),
        ],
      ),
    ));
  }
}
