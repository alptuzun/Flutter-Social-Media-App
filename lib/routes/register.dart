import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../visuals/colors.dart';
import '../visuals/screen_size.dart';
import '../visuals/text_style.dart';

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

  void handleEmailSave(String? val) {
    setState(() {
      email = val ?? "";
    });
  }

  Container formItem(
      TextInputType? inputType,
      IconData icon,
      String placeholder,
      String? Function(String?) _validator,
      void Function(String?)? _onSaved) {
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
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            fillColor: AppColors.textFieldFillColor,
            filled: true,
            labelStyle: appGreyText,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          validator: _validator,
          onSaved: _onSaved),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          centerTitle: true,
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Sabanci_Background.jpeg'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
                opacity: 0.40,
              ),
            ),
            child: SafeArea(
                child: Center(
              child: Column(
                children: [
                  formItem(TextInputType.emailAddress, Icons.email,
                      "Email Address", null, handleEmailSave),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        label: SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              Icon(Icons.password),
                              const SizedBox(width: 6),
                              Text(
                                'Password',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        fillColor: AppColors.textFieldFillColor,
                        filled: true,
                        labelStyle: appGreyText,
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
                            return 'Cannot leave password empty';
                          }
                          if (value.length < 6) {
                            return 'Password too short';
                          }
                        }
                      },
                      onSaved: (value) {
                        password = value ?? '';
                      },
                    ),
                  ),
                ],
              ),
            ))));
  }
}
