import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:cs310_group_28/services/auth.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/visuals/loading_screen.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/visuals/styled_button.dart';
import 'package:cs310_group_28/visuals/styled_password_field.dart';
import 'package:cs310_group_28/visuals/styled_text_field.dart';
import 'package:cs310_group_28/visuals/alerts.dart';

import '../services/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
  static const String routeName = "/register";
}

class _RegisterState extends State<Register> {
  String name = "";
  String email = "";
  String username = "";
  String password = "";
  String uid = "";
  final validCharacters = RegExp(r'^[a-zA-Z0-9_]+$');
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static final List<List<String>> interests = [
    ["Theatre", "🎭"],
    ["Chess", "♔"],
    ["Film Producing", "🎬"],
    ["Philosophy", "🤔"],
    ["Cycling", "🚵‍"],
    ["Gastronomy", "🌮"],
    ["Psychology", "👩‍"],
    ["Golf", "⛳️"],
    ["Diving", "🤿"],
    ["Music", "🎸"],
    ["Gender", "🏳️‍🌈"]
  ];
  List<bool> interestsSelected = List<bool>.filled(interests.length, false);

  List<String> _getSelectedInterests() {
    List<String> res = <String>[];
    for (int i = 0; i < interestsSelected.length; i++) {
      if (interestsSelected[i]) {
        res.add(interests[i][0]);
      }
    }
    return res;
  }

  String? usernameValidator(String? username) {
    if (username != null) {
      if (username.isEmpty) {
        return "Cannot leave username empty";
      } else if (!validCharacters.hasMatch(username)) {
        return "Please enter a proper username";
      }
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Cannot leave your name empty';
      }
      if (!value.contains(' ')) {
        return 'Please enter a proper full name';
      }
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Cannot leave your password empty';
      }
      if (value.length < 6) {
        return 'Please enter a valid password';
      }
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Cannot leave your email empty';
      } else if (!EmailValidator.validate(value)) {
        return 'Please enter a valid email address';
      }
    }
    return null;
  }

  Future<bool> registerUser() async {
    ConnectionWaiter.loadingScreen(context);
    bool unique = await UserService.uniqueUsername(username);
    if (unique) {
      dynamic result = await _auth.registerUserWithEmailPass(
          email, password, name, username);
      if (!mounted) {
        return false;
      }
      Navigator.of(context).pop();
      if (result is String) {
        Alerts.showAlert(context, 'Register Error', result.toString());
        return false;
      } else if (result is User) {
        setState(() {
          uid = result.uid;
        });
        analytics.logSignUp(signUpMethod: "Email_and_Password");
        return true;
      } else {
        Alerts.showAlert(context, 'Login Error', result.toString());
        return false;
      }
    } else {
      if (!mounted) {
        return false;
      }
      Navigator.of(context).pop();
      Alerts.showAlert(
          context, 'Login Error', "Please select a unique username");
      return false;
    }
  }
  Future<bool> loginWithGoogle() async {
    dynamic result = await _auth.signInWithGoogle();
    if (!mounted) {
      return false;
    }
    if (result is String) {
      return false;
    } else if (result is User) {
      analytics.logLogin(loginMethod: "Google Login");
      MySharedPreferences.instance.setBooleanValue("loggedIn", true);
      uid = result.uid;
      return true;
    } else {
      return false;
    }
    //return false;
  }



  Future<bool> loginWithFacebook() async {
    //ConnectionWaiter.loadingScreen(context);
    dynamic result = await _auth.signInWithFacebook();
    if (!mounted) {
      return false;
    }
    if (result is String) {
      Alerts.showAlert(context, 'Login Error', result);
    } else if (result is User) {
      analytics.logLogin(loginMethod: "Facebook Login");
      MySharedPreferences.instance.setBooleanValue("loggedIn", true);
      uid = result.uid;


      return true;
    } else {
      return false;
    }
    return false;

  }
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(controller: controller, children: <Widget>[
      Scaffold(
        backgroundColor: const Color(0xFFFFFAFA),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: (screenHeight(context, dividedBy: 20)),
              ),
              Image(
                image: const AssetImage("assets/images/logo.webp"),
                height: screenHeight(context, dividedBy: 2.75),
              ),
              SizedBox(
                height: screenHeight(context, dividedBy: 300),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: InputChip(
                            label: const Text("Sign in with Google"),
                            labelStyle: const TextStyle(fontSize: 16),
                            avatar: const CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/google_icon.png")),
                            onPressed: () async {

                              bool success = await loginWithGoogle();
                              if (success) {
                                controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              }
                              else {
                                if(!mounted) {
                                  return;
                                }
                                Alerts.showAlert(context, 'Signup Error',
                                    'Error to Login Facebook');
                              }
                            },
                            elevation: 3,
                            backgroundColor: Colors.white70,
                            padding: const EdgeInsets.all(5),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          child: InputChip(
                            label: const Text("Sign in with Facebook",style: TextStyle(color: Colors.white),),
                            labelStyle: const TextStyle(fontSize: 16),
                            avatar: const CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/facebook_icon.png")),
                            onPressed: ()async {

                                bool success = await loginWithFacebook();
                                if (success) {
                                  controller.nextPage(
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                }
                                else {
                                  if(!mounted) {
                                    return;
                                  }
                                Alerts.showAlert(context, 'Signup Error',
                                    'Error to Login Facebook');
                              }
                            } ,
                            elevation: 3,
                            backgroundColor: Colors.blueAccent.shade200,
                            padding: const EdgeInsets.all(10),
                          ),
                        ),
                      ],
                    ),



                    StyledTextField(
                        icon: Icons.account_box_sharp,
                        placeholder: 'Full Name',
                        validator: nameValidator,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        }),
                    StyledTextField(
                        icon: Icons.perm_identity_rounded,
                        placeholder: "Username",
                        validator: usernameValidator,
                        onChanged: (value) {
                          setState(() {
                            username = value;
                          });
                        }),
                    StyledTextField(
                      inputType: TextInputType.emailAddress,
                      icon: Icons.email,
                      placeholder: "Email Address",
                      validator: emailValidator,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    StyledPasswordField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: passwordValidator),
                    StyledButton(
                        label: "register",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            bool success = await registerUser();
                            if (success) {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          } else {
                            Alerts.showAlert(context, 'Signup Error',
                                'Please fill out the form correctly!');
                          }
                        })
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: const Color(0xFF012169),
                indent: screenWidth(context, dividedBy: 15),
                endIndent: screenWidth(context, dividedBy: 15),
              ),
              RichText(
                  text: TextSpan(
                      style: Styles.appMainTextStyle,
                      children: <TextSpan>[
                    TextSpan(
                      text: "Already have an account? ",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                        text: " Log In",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Login()));
                          }),
                  ])),
              SizedBox(
                height: (screenHeight(context) / 100) * 2,
              ),
            ],
          ),
        ),
      ),
      Scaffold(
          body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Select Your Interests",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 10),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text(
                  "Select your interests so that we can specialize your feed according to your selection. You can always edit your interests.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                )),
            SizedBox(
              height: screenHeight(context, dividedBy: 10),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              alignment: Alignment.center,
              child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 5,
                  children: [
                    for (int i = 0; i < interests.length; i++)
                      InputChip(
                        label: Text(interests[i][0]),
                        labelStyle: const TextStyle(fontSize: 16),
                        avatar: Text(
                          interests[i][1],
                          textAlign: TextAlign.center,
                        ),
                        elevation: 3,
                        backgroundColor: Colors.white70,
                        padding: const EdgeInsets.all(10),
                        selected: interestsSelected[i],
                        onPressed: () {
                          setState(() {
                            interestsSelected[i] = !interestsSelected[i];
                          });
                        },
                      ),
                  ]),
            ),
            SizedBox(
              height: screenHeight(context, dividedBy: 8),
            ),
            StyledButton(
                label: "Continue",
                onPressed: () {

                  UserService.setInterests(uid, _getSelectedInterests());
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageNavigator.routeName, (route) => false);
                }



                )
          ],
        ),
      ))
    ]);
  }
}
