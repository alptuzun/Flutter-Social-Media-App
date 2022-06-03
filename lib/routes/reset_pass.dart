import 'package:cs310_group_28/services/auth.dart';
import 'package:cs310_group_28/visuals/alerts.dart';
import 'package:cs310_group_28/visuals/loading_screen.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = "";

  Future resetPass() async {
    ConnectionWaiter.loadingScreen(context);
    dynamic results = await _auth.passwordResetEmail(email);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
    if (results is String) {
      Alerts.showAlert(context, 'Reset Error', results);
    }
    Alerts.showAlert(context, "Reset Email has been sent", "Please also check your spam folder.");
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
        maintainBottomViewPadding: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 9,
                  ),
                  Text(
                    "Reset your account password",
                    style: Styles.boldTitleTextStyle,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: EdgeInsets.zero,
                    width: screenWidth(context, dividedBy: 1.1),
                    height: screenHeight(context, dividedBy: 9.5),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      child: TextFormField(
                        onFieldSubmitted: (value) async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          isDense: true,
                          label: SizedBox(
                            height: (screenHeight(context) / 100) * 4,
                            width: screenWidth(context, dividedBy: 1.1),
                            child: Row(
                              children: [
                                const Icon(Icons.email),
                                SizedBox(
                                  width: screenWidth(context, dividedBy: 50),
                                ),
                                Text(
                                  'Please enter your email',
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
                              return 'Cannot leave email empty';
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
                  const Spacer(
                  ),
                  Container(
                    width: (screenWidth(context) / 100) * 45,
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await resetPass();
                          } else {
                            Alerts.showAlert(context, 'Reset Error',
                                'Please enter a email that matches an account');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          "Reset Password",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 9,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
