import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/ui/notification_card.dart';
import 'package:cs310_group_28/models/notification.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<Notifications> {
  List<MyNotification> notifications = [

    MyNotification(
        text: 'Alp commented on your post.',
        date: 'June 21'
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
        actions: <Widget>[

          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.lightGreen,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
      ),
    );
  }
}

