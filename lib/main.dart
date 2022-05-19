import 'package:cs310_group_28/routes/explore.dart';
import 'package:cs310_group_28/routes/home_view.dart';
import 'package:cs310_group_28/routes/marketplace.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:cs310_group_28/routes/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/routes/welcome.dart';
import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:cs310_group_28/routes/walkthrough.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


int? isViewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('walkthrough');


  runApp(MaterialApp(
    routes: {
      '/': isViewed != 0 ? (context) =>  const WalkThrough() : (context) => const Welcome(),
  //    '/': (context) => const Welcome(),
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
