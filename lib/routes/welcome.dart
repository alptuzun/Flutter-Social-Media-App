import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:cs310_group_28/visuals/styled_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);
  final Duration duration = const Duration(milliseconds: 600);
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    analytics.logEvent(name: "Opened_welcome_screen");
    final currUser = Provider.of<User?>(context);
    if (currUser == null) {
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
          maintainBottomViewPadding: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 4,
                  ),
                  FadeInUp(
                    duration: duration,
                    delay: const Duration(milliseconds: 2500),
                    child: const Text(
                      "Welcome!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                    duration: duration,
                    delay: const Duration(milliseconds: 2000),
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        left: 5,
                        right: 5,
                      ),
                      width: size.width,
                      height: size.height / 2,
                      child:
                          Lottie.asset("assets/images/an.json", animate: true),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: FadeInUp(
                      duration: duration,
                      delay: const Duration(milliseconds: 1500),
                      child: const Text(
                        "Keep various ways to contact and get in touch easily right from this app with all Sabanci University students.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 8,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Spacer(),
                    FadeInUp(
                        duration: duration,
                        delay: const Duration(milliseconds: 600),
                        child: StyledButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            label: "Login")),
                    const Spacer(),
                    FadeInUp(
                      duration: duration,
                      delay: const Duration(milliseconds: 600),
                      child: StyledButton(
                        label: "register",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: screenWidth(context, dividedBy: 8),
                        height: screenHeight(context, dividedBy: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: const Color(0xFF012169),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.refresh_outlined),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Welcome()));
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      FadeInUp(
                        duration: duration,
                        delay: const Duration(milliseconds: 200),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: screenWidth(context, dividedBy: 1.5),
                          height: screenHeight(context, dividedBy: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: const Color(0xFF012169),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            child: ElevatedButton(
                              onPressed: () => throw Exception(),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: Text(
                                "Throw Test Exception",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const PageNavigator();
    }
  }
}
