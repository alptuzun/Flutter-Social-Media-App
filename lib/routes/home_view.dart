import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const String routeName = "/home_view";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
            splashRadius: 27,
            icon: const Icon(Icons.notifications_none_rounded),
            color: Colors.grey,
            iconSize: 40,
            onPressed: () {
              null;
            },
          ),
          title: Text(
            "Feed",
            style: Styles.appBarTitleTextStyle,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
              splashRadius: 27,
              icon: const Icon(Icons.forum_outlined),
              color: Colors.grey,
              iconSize: 40,
              onPressed: () {
                null;
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xCBFFFFFF),
        body: SingleChildScrollView(
          child: Row(
          ),
        ),
      ),
    );
  }
}
