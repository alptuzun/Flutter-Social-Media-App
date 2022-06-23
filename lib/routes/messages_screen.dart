import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/services/messages_service.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/message.dart';
import 'package:cs310_group_28/ui/messagecard.dart';

import '../models/user.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({Key? key}) : super(key: key);

  static const String routeName = "/messages_screen";

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<Map<String, Message>> getMessages(List snapshotData) async {
    Map<String, Message> messages = {};
    for (var dataItem in snapshotData) {
      var userIDs = dataItem.data()["userIDs"];
      userIDs.removeWhere(
          (item) => item == FirebaseAuth.instance.currentUser!.uid);
      String userID = userIDs[0];
      var allMessagesWithThatUser =
          await dataItem.reference.collection("messages").orderBy("time").get();
      Message lastMessage =
          Message.fromFirestore(allMessagesWithThatUser.docs.last, null);
      messages[userID] = lastMessage;
    }
    return messages;
  }

  Future<Map<String, MyUser>> getUsers(List userInfos) async {
    Map<String, MyUser> users = {};
    for (var uSnapshot in userInfos) {
      var userInfo = uSnapshot.data()["userIDs"];
      userInfo.removeWhere(
          (item) => item == FirebaseAuth.instance.currentUser!.uid);
      String userID = userInfo[0];
      users[userID] = await UserService.getUser(userID);
    }
    return users;
  }

  Future<Map<String, dynamic>> getData(snapshotData) async {
    Map<String, dynamic> data = {};
    data["users"] = await getUsers(snapshotData);
    data["messages"] = await getMessages(snapshotData);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    analytics.logScreenView(screenName: "Messages", screenClass: "MessageBox");
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
              splashRadius: 27,
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 34,
              ),
              color: AppColors.titleColor,
              onPressed: () {
                Navigator.pop(context); // pop the context
              }),
          backgroundColor: Colors.white,
          title: Text(
            "Messages",
            style: Styles.appBarTitleTextStyle,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
              splashRadius: 27,
              icon: const Icon(Icons.search_outlined),
              color: AppColors.titleColor,
              iconSize: 40,
              onPressed: () async {
                // showSearch(
                //   context: context,
                //   delegate: MySearchDelegate(),
                // );
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xCBFFFFFF),
        body: StreamBuilder<dynamic>(
            stream: FirebaseFirestore.instance
                .collection("Messages")
                .where("userIDs",
                    arrayContains: FirebaseAuth.instance.currentUser!.uid)
                .snapshots()
                .map((event) => event.docs),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Scaffold(
                  body: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: SizedBox(
                        width: screenWidth(context),
                        height: screenHeight(context, dividedBy: 5),
                        child:
                            const Center(child: CircularProgressIndicator())),
                  ),
                );
              }
              return FutureBuilder(
                  future: getData(snapshot.data),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return Scaffold(
                        body: Container(
                          color: Colors.white,
                          margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                          child: SizedBox(
                              width: screenWidth(context),
                              height: screenHeight(context, dividedBy: 5),
                              child: const Center(
                                  child: CircularProgressIndicator())),
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: screenHeight(context, dividedBy: 60),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: snapshot.data!["users"].keys
                                    .map<Widget>((userID) => Messagecard(
                                          message: snapshot.data!["messages"]
                                              [userID],
                                          user: snapshot.data!["users"][userID],
                                        ))
                                    .toList(),
                              ),
                              SizedBox(
                                height: screenHeight(context, dividedBy: 60),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }
}

// class MySearchDelegate extends SearchDelegate {
//   final List allChats = sampleMessages.map((e) => e.fullName).toList();
//   final List allChatSuggestions = sampleMessages
//       .map((e) => e.fullName)
//       .toList()
//       .sublist(0, sampleMessages.length ~/ 2);
//
//   @override
//   Widget? buildLeading(BuildContext context) => IconButton(
//       onPressed: () => close(context, null),
//       icon: const Icon(Icons.arrow_back_ios_rounded));
//
//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//         IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () {
//             if (query.isEmpty) {
//               close(context, null);
//             } else {
//               query = "";
//             }
//           },
//         )
//       ];
//
//   @override
//   Widget buildResults(BuildContext context) {
//     final allResults = allChats
//         .where((element) => element.toLowerCase().contains(
//               query.toLowerCase(),
//             ))
//         .toList();
//
//     return ListView.builder(
//       itemCount: allResults.length,
//       itemBuilder: (context, index) => ListTile(
//           title: Text(allResults.elementAt(index)),
//           onTap: () {
//             const Center(
//               child: Text("alp"),
//             );
//           }),
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final allSuggestions = allChatSuggestions
//         .where((element) => element.toLowerCase().contains(
//               query.toLowerCase(),
//             ))
//         .toList();
//
//     return ListView.builder(
//       itemCount: allSuggestions.length,
//       itemBuilder: (context, index) =>
//           ListTile(title: Text(allSuggestions.elementAt(index))),
//     );
//   }
// }
