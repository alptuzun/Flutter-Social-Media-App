import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/notifications.dart';

class NotificationCard extends StatelessWidget {

  final Notifications notification;


  NotificationCard({required this.notification });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Padding(
        padding: EdgeInsets.all(10),
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