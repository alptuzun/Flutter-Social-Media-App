import 'package:cs310_group_28/models/message.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';

class Messagecard extends StatelessWidget {
  const Messagecard({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 3),
      child: InkWell(
        onTap: () {null;},
        splashColor: const Color(0xFFA1A1A1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.account_circle, size: 40),
                SizedBox(
                  width: screenWidth(context, dividedBy: 45),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.user.fullName,
                      style: Styles.userNameTextStyle,
                      textAlign: TextAlign.start,
                      textScaleFactor: 0.75,
                    ),
                    SizedBox(
                      width: screenWidth(context, dividedBy: 45),
                    ),
                    //if (message.message.length > 29)
                    if (message.isRead == true || message.incoming == false)
                      Text(
                        '${message.message}  ·  ${message.timeAgo}',
                        style: Styles.appGreyText
                      ),
                    if (message.isRead == false && message.incoming == true)
                      Text(
                        '${message.message}  ·  ${message.timeAgo}',
                        style: Styles.appMainTextStyle,
                      ),
                  ],
                ),
                const Spacer(),
                if (message.isRead != true && message.incoming == true)
                  const Icon(
                    Icons.circle,
                    size: 10,
                    color: Colors.blue,
                  ),
                if (message.isRead != true && message.incoming == true)
                  SizedBox(
                      width: screenWidth(context, dividedBy: 45)
                  ),
                if (message.messageType != "Private")
                  const Icon(
                    Icons.storefront,
                    size: 26,
                  ),
                if (message.messageType == "Private")
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
