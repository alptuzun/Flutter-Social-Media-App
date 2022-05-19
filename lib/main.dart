import 'package:cs310_group_28/routes/explore.dart';
import 'package:cs310_group_28/routes/home_view.dart';
import 'package:cs310_group_28/routes/marketplace.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:cs310_group_28/routes/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/routes/welcome.dart';
import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/page_navigator.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const Welcome(),
      Login.routeName: (context) => const Login(),
      Register.routeName: (context) => const Register(),
      HomeView.routeName: (context) => const HomeView(),
      PageNavigator.routeName: (context) => const PageNavigator(),
      MarketPlace.routeName: (context) => const MarketPlace(),
      Explore.routeName: (context) => const Explore(),
      UserProfile.routeName: (context) => const UserProfile(),

    },
  ));
}
