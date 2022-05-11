import 'package:cs310_group_28/routes/register.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/routes/welcome.dart';
import 'package:cs310_group_28/routes/login.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const Welcome(),
      Login.routeName: (context) => Login(),
      Register.routeName: (context) => Register()
    },
  ));
}
