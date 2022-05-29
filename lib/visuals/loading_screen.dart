import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key, required this.loadingText}) : super(key: key);
  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight(context, dividedBy: 100) * 40,
            ),
            const CircularProgressIndicator(),
            SizedBox(
              height: screenHeight(context, dividedBy: 100) * 10,
            ),
            RichText(
              textAlign: TextAlign.center,
              textScaleFactor: 2,
              text:
                  TextSpan(style: Styles.appMainTextStyle, children: <TextSpan>[
                const TextSpan(text: "Please Wait for the \n"),
                TextSpan(text: loadingText),
                const TextSpan(text: "\nto load")
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ConnectionWaiter {
  static Future<void> loadingScreen(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            //backgroundColor: hexToColor('#f26937'),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            //title: Text("My title"),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              margin: const EdgeInsets.all(10),
              height: screenHeight(context, dividedBy: 100) * 20,
              width: screenWidth(context, dividedBy: 100) * 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                      height: 60, width: 60, child: CircularProgressIndicator())
                ],
              ),
            ),
          );
        });
  }
}
