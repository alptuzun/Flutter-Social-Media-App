import 'package:cs310_group_28/visuals/app_dimensions.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/ui/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  chatBubble(Chat myChat) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: Dimensions.regularPadding,
              alignment: myChat.type == "sender"
                  ? Alignment.topLeft
                  : Alignment.topRight,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                padding: Dimensions.regularPadding,
                margin: const EdgeInsets.symmetric(vertical: 0.5),
                decoration: BoxDecoration(
                    color: myChat.type == "sender" ? Colors.white : Colors.blue,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 2,
                          blurRadius: 5)
                    ]),
                child: Text(
                  myChat.message,
                  style: Styles.appMainTextStyle,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 10, left: 5),
            child: Row(
              children: [
                IconButton(
                  color: AppColors.textFieldFillColor,
                  splashRadius: 25,
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/MJ.jpg'),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Michael Jordan",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  color: AppColors.textFieldFillColor,
                  splashRadius: 25,
                  iconSize: 30,
                  icon: const Icon(
                    Icons.settings,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: messageList.length,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                return chatBubble(messageList[index]);
              },
            ),
          ),
          Container(
            padding: Dimensions.regularPadding,
            height: screenHeight(context, dividedBy: 100) * 7,
            color: Colors.white,
            child: Row(
              children: [
                const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.attach_file),
                  iconSize: 25,
                  color: Colors.blueAccent,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    style: Styles.appMainTextStyle,
                    autocorrect: true,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Message..."
                    ),
                  ),
                ),
                const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.send_rounded),
                  iconSize: 25,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
