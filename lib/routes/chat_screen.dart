import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/services/messages_service.dart';
import 'package:cs310_group_28/visuals/app_dimensions.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/ui/chat_message.dart';

import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.user}) : super(key: key);
  final MyUser user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  final messageField = TextEditingController();
  chatBubble(Message message) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: Dimensions.regularPadding,
              alignment:
                  message.userID != FirebaseAuth.instance.currentUser!.uid
                      ? Alignment.topLeft
                      : Alignment.topRight,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                padding: Dimensions.regularPadding,
                margin: const EdgeInsets.symmetric(vertical: 0.5),
                decoration: BoxDecoration(
                    color:
                        message.userID != FirebaseAuth.instance.currentUser!.uid
                            ? Colors.white
                            : Colors.blue,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 2,
                          blurRadius: 5)
                    ]),
                child: Text(
                  message.message,
                  style: Styles.appMainTextStyle,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  String _getDocID(String id1, String id2) {
    if (id1.compareTo(id2) < 0) {
      return "$id1-$id2";
    }
    return "$id2-$id1";
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        stream: FirebaseFirestore.instance
            .collection("Messages")
            .doc(_getDocID(
                FirebaseAuth.instance.currentUser!.uid, widget.user.userID))
            .collection("messages")
            .orderBy("time")
            .snapshots()
            .map((event) =>
                event.docs.map((e) => Message.fromFirestore(e, null)).toList()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: SizedBox(
                    width: screenWidth(context),
                    height: screenHeight(context, dividedBy: 5),
                    child: const Center(child: CircularProgressIndicator())),
              ),
            );
          }
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
                      CircleAvatar(
                        maxRadius: 20,
                        backgroundImage: CachedNetworkImageProvider(
                            widget.user.profilePicture),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.user.username,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
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
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      return chatBubble(snapshot.data![index]);
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
                          controller: messageField,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Message..."),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          String message = messageField.text;
                          messageField.clear();
                          await MessageService.sendMessage(
                              Message(
                                  userID:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  message: message,
                                  time: DateTime.now(),
                                  messageType: "DM"),
                              widget.user.userID);
                        },
                        icon: const Icon(Icons.send_rounded),
                        iconSize: 25,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
