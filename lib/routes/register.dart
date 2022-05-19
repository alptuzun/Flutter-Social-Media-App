import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/ui/styled_button.dart';
import 'package:cs310_group_28/ui/styled_password_field.dart';
import 'package:cs310_group_28/ui/styled_text_field.dart';
import 'package:cs310_group_28/visuals/alerts.dart';

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
  final validCharacters = RegExp(r'^[a-zA-Z0-9_]+$');
  final _formKey = GlobalKey<FormState>();

  String? usernameValidator(String? username) {
    if (username != null) {
      if (username.isEmpty) {
        return "Cannot leave username empty";
      } else if ((username.length >= 4 && username.length <= 14) &&
          validCharacters.hasMatch(username)) {
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

  void handleNameSave(String? val) {
    setState(() {
      name = val ?? '';
    });
  }

  void handleUsernameSave(String? val) {
    setState(() {
      username = val ?? "";
    });
  }

  void handleEmailSave(String? val) {
    setState(() {
      email = val ?? "";
    });
  }

  void handlePasswordSave(String? val) {
    setState(() {
      password = val ?? "";
    });
  }

  void handleButtonPress() {
    if (kDebugMode) {
      print(
          "\nemail:$email,\npassword:$password,\nusername:$username,\nname:$name");
    }

    Navigator.pushNamedAndRemoveUntil(
        context, PageNavigator.routeName, (r) => false);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushNamedAndRemoveUntil(
          context, PageNavigator.routeName, (r) => false);
    } else {
      Alerts.showAlert(context, 'Login Error', 'Please enter your password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFAFA),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: (screenHeight(context, dividedBy: 40)),
              ),
              Image(
                image: const AssetImage("assets/images/logo.webp"),
                height: screenHeight(context, dividedBy: 2.75),
              ),
              SizedBox(
                height: screenHeight(context, dividedBy: 50),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    StyledTextField(
                        icon: Icons.account_box_sharp,
                        placeholder: 'Full Name',
                        validator: nameValidator,
                        onChanged: handleNameSave),
                    StyledTextField(
                        icon: Icons.perm_identity_rounded,
                        placeholder: "Username",
                        validator: usernameValidator,
                        onChanged: handleUsernameSave),
                    StyledTextField(
                      inputType: TextInputType.emailAddress,
                      icon: Icons.email,
                      placeholder: "Email Address",
                      validator: emailValidator,
                      onChanged: handleEmailSave,
                    ),
                    StyledPasswordField(
                        onChanged: handlePasswordSave,
                        validator: passwordValidator),
                    StyledButton(
                      label: "register",
                      onPressed: handleButtonPress,
                    )
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          }),
                  ])),
              SizedBox(
                height: (screenHeight(context) / 100) * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
