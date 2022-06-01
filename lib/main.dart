import 'package:cs310_group_28/models/shared_preferences.dart';
import 'package:cs310_group_28/routes/explore.dart';
import 'package:cs310_group_28/routes/home_view.dart';
import 'package:cs310_group_28/routes/marketplace.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:cs310_group_28/routes/user_profile.dart';
import 'package:cs310_group_28/routes/user_settings.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/routes/welcome.dart';
import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:cs310_group_28/routes/walkthrough.dart';
import 'package:cs310_group_28/visuals/loading_screen.dart';
import 'firebase_options.dart';

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
  bool initialLoad = false;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  late FirebaseAnalytics analytics;

  _MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("initialLoad")
        .then((value) => setState(() {
              initialLoad = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // analytics = FirebaseAnalytics.instance;
          // analytics.logEvent(name: "Failed_to_load_the_app");
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                    'No Firebase Connection: ${snapshot.error.toString()}'),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          analytics = FirebaseAnalytics.instance;
          analytics.logAppOpen();
          return MaterialApp(
            home: initialLoad ? Welcome() : const WalkThrough(),
            routes: {
              Login.routeName: (context) => const Login(),
              Register.routeName: (context) => const Register(),
              HomeView.routeName: (context) => const HomeView(),
              PageNavigator.routeName: (context) => const PageNavigator(),
              MarketPlace.routeName: (context) => const MarketPlace(),
              Explore.routeName: (context) => const Explore(),
              UserProfile.routeName: (context) => const UserProfile(),
              UserSettings.routeName: (context) => const UserSettings(),
            },
          );
        }
        return const MaterialApp(home: Splash(loadingText: "FireBase App"));
      },
    );
  }
}
