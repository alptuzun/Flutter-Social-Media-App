import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.notification }) : super(key: key);
  final MyNotification notification;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              notification.text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
                "${notification.date.day}-${notification.date.month}-${notification.date.year}",
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                )
            ),
          ],
        ),
      ),
    );
  }
}