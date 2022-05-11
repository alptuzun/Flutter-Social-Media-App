import 'package:flutter/material.dart';
import 'package:sabanci_app/routes/welcome.dart';
import 'package:sabanci_app/routes/login.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const Welcome(),
      Login.routeName: (context) => Login(),
    },
  ));
}


