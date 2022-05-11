import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'dart:io' show Platform;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/gestures.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();

  static const String routeName = "/login";
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title, style: appBarTitleTextStyle),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message, style: appMainTextStyle),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Sabanci_Background.jpeg'),
          fit: BoxFit.cover,
          alignment: Alignment.center,
          opacity: 0.30,
        ),
        color: Color(0xEBFFFFFF),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            reverse: true,
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 180,
                    ),
                    Text(
                      "Welcome!",
                      style: boldTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 190,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: screenWidth(context, dividedBy: 1.2),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 8,
                        shadowColor: Colors.black45,
                        borderRadius: BorderRadius.circular(30),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            isDense: true,
                            label: SizedBox(
                              width: 250,
                              child: Row(
                                children: [
                                  const Icon(Icons.email),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Login with username or email',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: appBarTitleTextStyle,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'Cannot leave e-mail empty';
                              }
                              else if (!EmailValidator.validate(value)) {
                                return 'Please enter a valid e-mail address';
                              }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email = value ?? '';
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: screenWidth(context, dividedBy: 1.2),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        elevation: 8,
                        shadowColor: Colors.black45,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            isDense: true,
                            label: SizedBox(
                              width: 300,
                              child: Row(
                                children: [
                                  const Icon(Icons.password),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Password',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: appBarTitleTextStyle,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'Cannot leave password empty';
                              }
                              if (value.length < 6) {
                                return 'Password too short';
                              }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value ?? '';
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 190,
                      height: 45.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment(0, -1),
                            end: Alignment(0, 0),
                            colors: [Colors.lightBlue, Colors.lightBlueAccent]),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                            } else {
                              _showDialog('Form Error', 'Your form is invalid');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            "Log In",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        style: appMainTextStyle,
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
                                  // forgot Your Password
                                }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1.5,
                      indent: 90,
                      endIndent: 90,
                    ),
                    RichText(
                      text: TextSpan(
                        style: appMainTextStyle,
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
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                                }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
