import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:cs310_group_28/visuals/text_style.dart';

class Alerts {
  static Future<void> showAlert(
      BuildContext context, String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title, textAlign: TextAlign.center),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message, textAlign: TextAlign.center),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title, style: Styles.appBarTitleTextStyle),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message, style: Styles.appMainTextStyle),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        });
  }

  static Future<void> showOptions(
      BuildContext context,
      String title,
      String message,
      String button1,
      String button2,
      onPressed1,
      onPressed2) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title,
                  textAlign: TextAlign.center,
                  style: Styles.appBarTitleTextStyle),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message,
                        textAlign: TextAlign.center,
                        style: Styles.appMainTextStyle),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: onPressed1,
                  child: Text(button1, textAlign: TextAlign.center),
                ),
                TextButton(
                  onPressed: onPressed2,
                  child: Text(button2, textAlign: TextAlign.start),
                ),
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title,
                  style: Styles.appBarTitleTextStyle,
                  textAlign: TextAlign.center),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message,
                        style: Styles.appMainTextStyle,
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: onPressed1,
                  child: Text(button1),
                ),
                TextButton(
                  onPressed: onPressed2,
                  child: Text(button2),
                ),
              ],
            );
          }
        });
  }
}
