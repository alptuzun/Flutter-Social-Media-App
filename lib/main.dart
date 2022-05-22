import 'package:cs310_group_28/models/shared_preferences.dart';
import 'package:cs310_group_28/routes/explore.dart';
import 'package:cs310_group_28/routes/home_view.dart';
import 'package:cs310_group_28/routes/marketplace.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:cs310_group_28/routes/user_profile.dart';
import 'package:cs310_group_28/routes/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/routes/welcome.dart';
import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:cs310_group_28/routes/walkthrough.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool loggedIn = false;

  _MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("loggedIn")
        .then((value) => setState(() {
              loggedIn = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loggedIn ? const Welcome() : const WalkThrough(),
      routes: {
        Login.routeName: (context) => const Login(),
        Register.routeName: (context) => const Register(),
        HomeView.routeName: (context) => const HomeView(),
        PageNavigator.routeName: (context) => const PageNavigator(),
        MarketPlace.routeName: (context) => const MarketPlace(),
        Explore.routeName: (context) => const Explore(),
        UserProfile.routeName: (context) => const UserProfile(),
        UserSettings.routeName: (context) => const UserSettings(),
      }
    );
  }
}
