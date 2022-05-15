import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';


class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome!",
                  style: Styles.boldTitleTextStyle,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Spacer(),
                  Container(
                    width: (screenWidth(context) / 100) * 40,
                    height: (screenHeight(context) / 100) * 6,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 0),
                          colors: [Colors.lightBlue, Colors.lightBlueAccent]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Login()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        "Log In",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: (screenWidth(context) / 100) * 40,
                    height: (screenHeight(context) / 100) * 6,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 0),
                          colors: [Colors.lightBlue, Colors.lightBlueAccent]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ),
                  const Spacer(),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
