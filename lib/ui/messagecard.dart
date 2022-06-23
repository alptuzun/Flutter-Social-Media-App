import 'package:cached_network_image/cached_network_image.dart';
import 'package:cs310_group_28/models/message.dart';
import 'package:cs310_group_28/routes/chat_screen.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';

import '../models/user.dart';

class Messagecard extends StatelessWidget {
  const Messagecard({Key? key, required this.message, required this.user})
      : super(key: key);

  final Message message;
  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatScreen(user: user);
          }));
        },
        splashColor: const Color(0xFFA1A1A1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: screenWidth(context) / 15,
                  backgroundImage:
                      CachedNetworkImageProvider(user.profilePicture),
                ),
                SizedBox(
                  width: screenWidth(context, dividedBy: 45),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: Styles.userNameTextStyle,
                      textAlign: TextAlign.start,
                      textScaleFactor: 0.75,
                    ),
                    SizedBox(
                      width: screenWidth(context, dividedBy: 45),
                    ),
                    //if (message.message.length > 29)
                    if (message.isRead == true)
                      Text(
                          '${message.message}  · ${message.time.day}-${message.time.month}-${message.time.year}',
                          style: Styles.appGreyText),
                    if (message.isRead == false)
                      Text(
                        '${message.message}  ·  ${message.time.day}-${message.time.month}-${message.time.year}',
                        style: Styles.appMainTextStyle,
                      ),
                  ],
                ),
                const Spacer(),
                if (message.isRead)
                  const Icon(
                    Icons.circle,
                    size: 10,
                    color: Colors.blue,
                  ),
                if (message.isRead != true)
                  SizedBox(width: screenWidth(context, dividedBy: 45)),
                if (message.messageType != "DM")
                  const Icon(
                    Icons.storefront,
                    size: 26,
                  ),
                if (message.messageType == "DM")
                  const Icon(
                    Icons.send_sharp,
                    size: 26,
                  ),
                SizedBox(
                  width: screenWidth(context, dividedBy: 45),
                ),
              ]),
        ),
      ),
    );
  }
}
