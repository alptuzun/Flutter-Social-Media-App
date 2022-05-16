import 'package:cs310_group_28/visuals/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/visuals/text_style.dart';

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

  bool usernameValidator(String username) {
    if ((username.length >= 4 && username.length <= 14) && validCharacters.hasMatch(username)) {
      return true;
    }
    else {
      return false;
    }
  }

  Container formItem(

      TextInputType? inputType,
      IconData icon,
      String placeholder,
      String? Function(String?)? validator,
      void Function(String?)? onSaved) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
          keyboardType: inputType ?? TextInputType.text,
          decoration: InputDecoration(
            label: SizedBox(
              width: 300,
              child: Row(
                children: [
                  Icon(icon),
                  const SizedBox(width: 6),
                  Text(
                    placeholder,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            fillColor: AppColors.textFieldFillColor,
            filled: true,
            labelStyle: Styles.appGreyText,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          validator: validator,
          onSaved: onSaved),
    );
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
          appBar: AppBar(
            title: Text(
              'REGISTER',
              style: Styles.appBarTitleTextStyle,
            ),
            backgroundColor: Colors.blue,
            centerTitle: true,
            elevation: 0.0,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  formItem(TextInputType.emailAddress, Icons.email, "Email Address", null, handleEmailSave),
                  formItem(TextInputType.text, Icons.password, "Password", null, handlePasswordSave),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        label: SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              const Icon(Icons.account_box_sharp),
                              const SizedBox(width: 6),
                              Text(
                                'Full Name',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        fillColor: AppColors.textFieldFillColor,
                        filled: true,
                        labelStyle: Styles.appGreyText,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.mainTextColor,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Cannot leave your name empty';
                          }
                          if (!value.contains(' ')){
                            return 'Please enter a proper full name';
                          }
                        }
                        return null;
                      },
                      onSaved: (value) {
                        name = value ?? '';
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      decoration: InputDecoration(
                        label: SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              const Icon(Icons.perm_identity_rounded),
                              const SizedBox(width: 6),
                              Text(
                                'Username',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        fillColor: AppColors.textFieldFillColor,
                        filled: true,
                        labelStyle: Styles.appGreyText,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.mainTextColor,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Cannot leave your username empty';
                          }
                          else if (!usernameValidator(value)){
                            return 'Please enter a valid username';
                          }
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value ?? '';
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
