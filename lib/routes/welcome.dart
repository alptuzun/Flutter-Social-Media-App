import 'package:flutter/material.dart';
import 'package:cs310_group_28/routes/login.dart';
import 'package:cs310_group_28/routes/register.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:cs310_group_28/ui/styled_button.dart';

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
