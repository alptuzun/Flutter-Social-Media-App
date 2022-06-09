import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/message.dart';
import 'package:cs310_group_28/ui/messagecard.dart';

List<Message> sampleMessages = [
  Message(
    message: "I will think about it.",
    time: DateTime.now(),
      username: 'klcilkr',
    fullName: "İlker Kılıç",
    messageType: "Market Place",
    isRead: true,
    incoming: true,
  ),
  Message(
    message: "Ok it is done.",
    time: DateTime.now(),

      username: 'Sila',
      fullName: 'Sıla Özinan',

    messageType: "Market Place",
    isRead: false,
    incoming: true,
  ),
  Message(
    message: "Deal!, I am selling my F1 car to you.",
    time: DateTime.now(),

      username: 'lewis',
      fullName: 'Lewis Hamilton',

    messageType: "Market Place",
    isRead: true,
    incoming: true,
  ),
  Message(
    message: "See u",
    time: DateTime.now(),

      username: 'sermetozgu',
      fullName: 'Sermet Özgü',


    messageType: "Private",
    isRead: true,
    incoming: false,
  ),
  Message(
    message: "200\$ is ok for you?",
    time: DateTime.now(),

      username: "alptuzun",

      fullName: "Alp Tüzün",

    messageType: "Market Place",
    incoming: true,
    isRead: true,
  ),
  Message(
      message: "Have you cheated on ...",
      time: DateTime.now(),

        username: 'levi',
        fullName: 'Albert Levi',

      messageType: "Private",
      incoming: true,
      isRead: false),
  Message(
      message: "This Wednesday is ok.",
      time: DateTime.now(),

        username: 'ozgun12',
        fullName: 'Ali Özgün Akyüz',

      messageType: "Private",
      incoming: true,
      isRead: false),
  Message(
    message: "I'll handle it",
    time: DateTime.now(),

      username: 'emre26',
      fullName: 'Emre Güneş',

    messageType: "Private",
    isRead: true,
    incoming: true,
  ),
  Message(
    message: "Hii",
    time: DateTime.now(),

      username: "isiktantanis",

      fullName: "Işıktan Tanış",

    messageType: "Market Place",
    incoming: true,
    isRead: false,
  ),
  Message(
      message: "OK",
      time: DateTime.now(),

        username: 'eylül.simsek',
        fullName: 'Eylül Şimşek',

      messageType: "Private",
      isRead: true,
      incoming: false),
];

class MessageBox extends StatefulWidget {
  const MessageBox({Key? key}) : super(key: key);

  static const String routeName = "/messages_screen";

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

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
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xCBFFFFFF),
        body: SingleChildScrollView(
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
                    children: sampleMessages
                        .map((message) => Messagecard(
                              message: message,
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
        ));
  }
}

class MySearchDelegate extends SearchDelegate {
  final List allChats =
      sampleMessages.map((e) => e.fullName).toList();
  final List allChatSuggestions = sampleMessages
      .map((e) => e.fullName)
      .toList()
      .sublist(0, sampleMessages.length ~/ 2);

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios_rounded));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
        )
      ];

  @override
  Widget buildResults(BuildContext context) {
    final allResults = allChats
        .where((element) => element.toLowerCase().contains(
              query.toLowerCase(),
            ))
        .toList();

    return ListView.builder(
      itemCount: allResults.length,
      itemBuilder: (context, index) => ListTile(
          title: Text(allResults.elementAt(index)),
          onTap: () {
            const Center(
              child: Text("alp"),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final allSuggestions = allChatSuggestions
        .where((element) => element.toLowerCase().contains(
              query.toLowerCase(),
            ))
        .toList();

    return ListView.builder(
      itemCount: allSuggestions.length,
      itemBuilder: (context, index) =>
          ListTile(title: Text(allSuggestions.elementAt(index))),
    );
  }
}
