import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:cs310_group_28/ui/styled_button.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.logEvent(name: "Opened_welcome_screen");
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
                Text(
                  "Welcome!",
                  style: Styles.boldTitleTextStyle,
                ),
                const Spacer(
                  flex: 8,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Spacer(),
                  StyledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      label: "Login"),
                  const Spacer(),
                  StyledButton(
                    label: "register",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                  ),
                  const Spacer(),
                ]),
                const Spacer(),
                Container(
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
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
