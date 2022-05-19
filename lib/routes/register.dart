import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/ui/styled_button.dart';
import 'package:cs310_group_28/ui/styled_password_field.dart';
import 'package:cs310_group_28/ui/styled_text_field.dart';

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

  String usernameValidator(String? username) {
    if (username == null) {
      return "Username cannot be blank.";
    }
    if ((username.length >= 4 && username.length <= 14) &&
        validCharacters.hasMatch(username)) {
      return "";
    } else {
      return "Enter a valid username";
    }
  }

  String nameValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Cannot leave your name empty';
      }
      if (!value.contains(' ')) {
        return 'Please enter a proper full name';
      }
    }
    return "";
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

  void handleButtonPress() {
    if (kDebugMode) {
      print(
          "\nemail:$email,\npassword:$password,\nusername:$username,\nname:$name");
    }
    Navigator.pushNamedAndRemoveUntil(
          context, PageNavigator.routeName, (r) => false);
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
            children: [
              SizedBox(
                height: (screenHeight(context) / 100) * 2.5,
              ),
              Image(
                image: const AssetImage("assets/images/logo.webp"),
                height: screenHeight(context, dividedBy: 2.75),
              ),
              SizedBox(
                height: (screenHeight(context) / 100) * 2,
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
                        placeholder: ("Email Address"),
                        onChanged: handleEmailSave),
                    StyledPasswordField(onChanged: handlePasswordSave),
                    StyledButton(
                      label: "register",
                      onPressed: handleButtonPress,
                    )
                  ],
                ),
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
                      text: "Already have an account? ",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        letterSpacing: -0.7,
                      ),
                    ),
                    TextSpan(
                        text: " Log In",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.7,
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
