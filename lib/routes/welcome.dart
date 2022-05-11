import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabanci_app/routes/login.dart';
import 'package:sabanci_app/routes/register.dart';
import 'package:sabanci_app/visuals/colors.dart';
import 'package:sabanci_app/visuals/app_dimensions.dart.';
import 'package:sabanci_app/visuals/text_style.dart';

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
          opacity: 0.40,
        ),
        color: Color(0xD7FFFFFF),
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
                  style: boldTitleTextStyle,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    width: 170,
                    height: 48.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 0),
                          colors: [Colors.lightBlue, Colors.lightBlueAccent]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 170,
                    height: 48.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 0),
                          colors: [Colors.lightBlue, Colors.lightBlueAccent]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
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
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
