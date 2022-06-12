import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/ui/notification_card.dart';
import 'package:cs310_group_28/models/notification.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<Notifications> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  List<MyNotification> notifications = [
    MyNotification(
      userID: ,
      type: 'comment',
      date: DateTime.now(),
    ),
    MyNotification(
      userID: ,
      type: 'follow',
      date: DateTime.now(),
    ),
    MyNotification(
      userID: ,
      type: 'like',
      date: DateTime.now(),
    ),
    MyNotification(
      userID: ,
      type: 'message',
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
    final user = Provider.of<User?>(context);
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Users").snapshots().asBroadcastStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<dynamic> userList = snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) {
                return element["userID"] == user!.uid;
              }).toList();
              MyUser myUser =
              MyUser.fromJson(userList[0].data() as Map<String, dynamic>);
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                      children: myUser.notifications.reversed
                          .map((newNotification) => NotificationCard(
                          myNotification:
                          AppNotification.fromJson(newNotification), notification: null,))
                          .toList()),
                ),
              );
            }
          }),

    );
  }
}
