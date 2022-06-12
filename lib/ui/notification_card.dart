import 'package:cs310_group_28/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/notification.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key, required this.notification }) : super(key: key);
  final MyNotification notification;

  @override
  State<NotificationCard> createState() => _NotificationCardState();

}

class _NotificationCardState extends State<NotificationCard> {
  String username = 'user';
  Future getUsername() async {
    final name = await UserService.getUsername(widget.notification.userID);
    setState(() {
      username = name;
    });
  }

  @override
  void initState(){
   getUsername();
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.notification.type == 'follow') {
      return Card(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "$username followed you.",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                  "${widget.notification.date.day}.${widget.notification.date
                      .month}.${widget.notification.date.year}",
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
    else if(widget.notification.type == 'like') {
      return Card(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "$username liked your post.",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                  "${widget.notification.date.day}.${widget.notification.date.month}.${widget.notification.date.year}",
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
    else if(widget.notification.type == 'comment') {
      return Card(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "$username commented to your post.",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                  "${widget.notification.date.day}.${widget.notification.date.month}.${widget.notification.date.year}",
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
    else if(widget.notification.type == 'dislike') {
      return Card(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "$username disliked your post.",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                  "${widget.notification.date.day}.${widget.notification.date.month}.${widget.notification.date.year}",
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
    else {
      return Card(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "$username sent a message.",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                  "${widget.notification.date.day}.${widget.notification.date.month}.${widget.notification.date.year}",
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
}