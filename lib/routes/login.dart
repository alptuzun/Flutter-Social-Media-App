import 'dart:convert';

import 'package:cs310_group_28/routes/home_view.dart';
import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:cs310_group_28/routes/reset_pass.dart';
import 'package:cs310_group_28/visuals/loading_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/gestures.dart';
import 'package:cs310_group_28/visuals/alerts.dart';
import 'package:cs310_group_28/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cs310_group_28/services/shared_preferences.dart';

import '../visuals/styled_button.dart';
import '../visuals/styled_password_field.dart';
import '../visuals/styled_text_field.dart';

//facebook login try



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();

  static const String routeName = "/login";
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = "";
  String pass = "";
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future loginUser() async {
    ConnectionWaiter.loadingScreen(context);
    dynamic result = await _auth.signInWithEmailPass(email, pass);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
    if (result is String) {
      Alerts.showAlert(context, 'Login Error',
          "Invalid email or password.\nPlease try again");
    } else if (result is User) {
      analytics.logLogin(loginMethod: "Email & Password");
      MySharedPreferences.instance.setBooleanValue("loggedIn", true);
      Navigator.pushNamedAndRemoveUntil(
          context, PageNavigator.routeName, (route) => false);
    } else {
      Alerts.showAlert(context, 'Login Error', result.toString());
    }
  }

  Future loginAnon() async {
    ConnectionWaiter.loadingScreen(context);
    dynamic result = await _auth.signInAnon();
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
    if (result is String) {
      Alerts.showAlert(context, 'Login Error', result);
    } else if (result is User) {
      analytics.logLogin(loginMethod: "Anonymously");
      Navigator.pushNamedAndRemoveUntil(
          context, PageNavigator.routeName, (route) => false);
    } else {
      Alerts.showAlert(context, 'Login Error', result.toString());
    }
  }

  Future loginWithGoogle() async {
    dynamic result = await _auth.signInWithGoogle();
    if (!mounted) {
      return;
    }
    if (result is String) {
      Alerts.showAlert(context, 'Login Error', result);
    } else if (result is User) {
      analytics.logLogin(loginMethod: "Google Login");
      Navigator.pushNamedAndRemoveUntil(
          context, PageNavigator.routeName, (route) => false);
    } else {
      Alerts.showAlert(context, 'Login Error', result.toString());
    }
  }




  Future loginWithFacebook() async {
    //ConnectionWaiter.loadingScreen(context);
    dynamic result = await _auth.signInWithFacebook();
    if (!mounted) {
      return;
    }
    if (result is String) {
      Alerts.showAlert(context, 'Login Error', result);
    } else if (result is User) {
      analytics.logLogin(loginMethod: "Facebook Login");
      MySharedPreferences.instance.setBooleanValue("loggedIn", true);
      Navigator.pushNamedAndRemoveUntil(
          context, PageNavigator.routeName, (route) => false);
    } else {
      Alerts.showAlert(context, 'Login Error', result.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: (screenHeight(context) / 100) * 5,
            ),
            Image(
              image: const AssetImage("assets/images/logo.webp"),
              height: screenHeight(context, dividedBy: 2.75),
            ),
            SizedBox(
              height: (screenHeight(context, dividedBy: 20)),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: InputChip(
                    label: const Text("Log in with Google"),
                    labelStyle: const TextStyle(fontSize: 16),
                    avatar: const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/google_icon.png")),
                    onPressed: () async {
                      await loginWithGoogle();
                    },
                    elevation: 3,
                    backgroundColor: Colors.white70,
                    padding: const EdgeInsets.all(10),
                  ),
                ),


                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: InputChip(
                    label: const Text("Log in with Facebook",style: TextStyle(color: Colors.white),),
                    labelStyle: const TextStyle(fontSize: 16),
                    avatar: const CircleAvatar(
                        backgroundImage:
                        AssetImage("assets/images/facebook_icon.png")),
                    onPressed: () {
                      loginWithFacebook();
                    },
                    elevation: 3,
                    backgroundColor: Colors.blueAccent.shade200,
                    padding: const EdgeInsets.all(10),
                  ),
                ),

              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  StyledTextField(
                    inputType: TextInputType.emailAddress,
                    icon: Icons.email,
                    placeholder: "Email Address",
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Cannot leave email or username empty';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email address';
                        }
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  StyledPasswordField(onChanged: (value) {
                    setState(() {
                      pass = value;
                    });
                  }, validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave password empty';
                      }
                      if (value.length < 6) {
                        return 'Password too short';
                      }
                    }
                    return null;
                  }),
                  SizedBox(
                    height: (screenHeight(context) / 110),
                  ),
                  StyledButton(
                    label: "login",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await loginUser();
                      } else {
                        Alerts.showAlert(context, 'Login Error',
                            'Your credentials are invalid');
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: (screenHeight(context) / 100) * 1.5,
            ),
            RichText(
              text: TextSpan(
                style: Styles.appMainTextStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: 'Forgot your password?',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResetPassword()));
                        }),
                ],
              ),
            ),
            SizedBox(
              height: (screenHeight(context) / 100) * 4,
            ),
            Divider(
              color: Colors.black,
              thickness: 1.5,
              indent: (screenWidth(context) / 100) * 15,
              endIndent: (screenWidth(context) / 100) * 15,
            ),
            RichText(
              text: TextSpan(
                style: Styles.appMainTextStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: "Don't have an account? ",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      letterSpacing: -0.7,
                    ),
                  ),
                  TextSpan(
                      text: " Register",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.7,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Register()));
                        }),
                ],
              ),
            ),
            SizedBox(
              height: (screenHeight(context) / 100) * 2,
            ),
          ],
        ),
      ),
    );
  }



}
