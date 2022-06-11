import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/ui/notification_card.dart';
import 'package:cs310_group_28/models/notification.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/text_style.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<Notifications> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  List<MyNotification> notifications = [
    MyNotification(
      text: 'Alp commented on your post.',
      date: DateTime.now(),
    ),
    MyNotification(
      text: 'Sermet followed you.',
      date: DateTime.now(),
    ),
    MyNotification(
      text: 'Your friend Işıktan joined the App',
      date: DateTime.now(),
    ),
    MyNotification(
      text: 'Sıla wants to buy your item',
      date: DateTime.now(),
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
    analytics.logScreenView(
        screenName: "Notification", screenClass: "Notifications");
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
            icon: const Icon(
              Icons.arrow_back_rounded,
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
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              Column(
                children: notifications
                    .map((notifications) => NotificationCard(
                          notification: notifications,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
