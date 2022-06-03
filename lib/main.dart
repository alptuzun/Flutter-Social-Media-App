import 'package:cs310_group_28/services/auth.dart';
import 'package:cs310_group_28/services/shared_preferences.dart';
import 'package:cs310_group_28/routes/explore.dart';
import 'package:cs310_group_28/routes/home_view.dart';
import 'package:cs310_group_28/routes/marketplace.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:cs310_group_28/routes/user_profile.dart';
import 'package:cs310_group_28/routes/user_settings.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/routes/welcome.dart';
import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:cs310_group_28/routes/walkthrough.dart';
import 'package:cs310_group_28/visuals/loading_screen.dart';
import 'package:cs310_group_28/util/firebase_options.dart';
import 'package:provider/provider.dart';

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
          FirebaseAnalytics analytics = FirebaseAnalytics.instance;
          FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
          analytics.logAppOpen();
          return StreamProvider<User?>.value(
            value: AuthService().user,
            initialData: null,
            child: MaterialApp(
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
            ),
          );
        }
        return const MaterialApp(home: Splash(loadingText: "FireBase App"));
      },
    );
  }
}
