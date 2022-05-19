import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/ui/notification_card.dart';
import 'package:cs310_group_28/models/notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/text_style.dart';


class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<Notifications> {
  List<MyNotification> notifications = [

    MyNotification(
        text: 'Alp commented on your post.',
        date: 'May 10'
    ),
    MyNotification(
        text: 'Sermet followed you.',
        date: 'May 4'
    ),
    MyNotification(
        text: 'Your friend Işıktan joined the App',
        date: 'April 28'
    ),
    MyNotification(
        text: 'Sıla wants to buy your item',
        date: 'April 20'
    ),
  ];

  int notificationCount = 0;

  void deleteNotification(MyNotification notification) {
    setState(() {
      notifications.remove(notification);
    });
  }

  void buttonClicked() {
    setState(() {
      notificationCount++;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (kDebugMode) {
      print('build');
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.titleColor,
            ),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
          'Notifications',
          style: Styles.appBarTitleTextStyle,
          )
        ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(width: 8,),
                ],
              ),
              Column(
                children: notifications.map((notifications) => NotificationCard(
                  notification: notifications,
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

