import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.notification }) : super(key: key);
  final MyNotification notification;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              notification.text,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    notification.date,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )
                ),
                const Spacer(),
                const SizedBox(width: 8),
                const SizedBox(width: 8),
              ],
            )
          ],
        ),
      ),
    );
  }
}