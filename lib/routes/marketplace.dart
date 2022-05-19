import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

  static const routeName = '/marketplace';

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Market Place",
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
    );
  }
}
