import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/gestures.dart';
import 'package:cs310_group_28/visuals/alerts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();

  static const String routeName = "/login";
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

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
              height: (screenHeight(context) / 100) * 4,
            ),
            Image(
              image: const AssetImage("assets/images/logo.webp"),
              height: screenHeight(context, dividedBy: 2.75),
            ),
            SizedBox(
              height: (screenHeight(context) / 100) * 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: screenWidth(context, dividedBy: 1.1),
                    height: screenHeight(context, dividedBy: 9),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          if (value == "") {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, PageNavigator.routeName, (r) => false);
                            } else {
                              Alerts.showAlert(context, 'Login Error',
                                  'Please enter your email');
                            }
                          } else {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, PageNavigator.routeName, (r) => false);
                            } else {
                              Alerts.showAlert(context, 'Login Error',
                                  'Your credentials are invalid');
                            }
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          isDense: true,
                          label: SizedBox(
                            width: screenWidth(context, dividedBy: 1.2),
                            child: Row(
                              children: [
                                const Icon(Icons.email),
                                SizedBox(
                                  width: screenWidth(context, dividedBy: 50),
                                ),
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
                          labelStyle: Styles.appBarTitleTextStyle,
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
                              return 'Cannot leave email or username empty';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid email address';
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
                    width: screenWidth(context, dividedBy: 1.1),
                    height: screenHeight(context, dividedBy: 9),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Colors.black45,
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          if (value == "") {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, PageNavigator.routeName, (r) => false);
                            } else {
                              Alerts.showAlert(context, 'Login Error',
                                  'Please enter your password');
                            }
                          } else {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, PageNavigator.routeName, (r) => false);
                            } else {
                              Alerts.showAlert(context, 'Login Error',
                                  'Your credentials are invalid');
                            }
                          }
                        },
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                          isDense: true,
                          label: SizedBox(
                            width: screenWidth(context, dividedBy: 1.2),
                            child: Row(
                              children: [
                                const Icon(Icons.password),
                                SizedBox(
                                  width: screenWidth(context, dividedBy: 50),
                                ),
                                Text(
                                  'Password',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelStyle: Styles.appBarTitleTextStyle,
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
                  SizedBox(
                    height: (screenHeight(context) / 100) * 2,
                  ),
                  Container(
                    width: (screenWidth(context) / 100) * 48,
                    height: (screenHeight(context) / 100) * 5.5,
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
                            Navigator.pushNamedAndRemoveUntil(
                                context, PageNavigator.routeName, (r) => false);
                          } else {
                            Alerts.showAlert(context, 'Login Error',
                                'Your credentials are invalid');
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
                          // forgot Your Password
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
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
