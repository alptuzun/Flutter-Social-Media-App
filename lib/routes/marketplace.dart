import 'package:cs310_group_28/ui/marketcard.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:cs310_group_28/models/post.dart';
import 'messages_screen.dart';
import 'notifications.dart';

List<Post> sampleMarkets = [];

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key, this.leading}) : super(key: key);
  final bool? leading;

  static const routeName = '/marketplace';

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void addToBasket(Post post) {
    setState(() {
      analytics.logAddToCart(currency: "TRY", value: 1500);
    });
  }

  @override
  Widget build(BuildContext context) {
    analytics.logScreenView(
        screenClass: "MarketPlace", screenName: "Market Place");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: (widget.leading != null && widget.leading == true)
            ? IconButton(
                padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.titleColor,
                ),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : IconButton(
                padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
                splashRadius: 27,
                icon: const Icon(Icons.notifications_none_rounded),
                color: Colors.grey,
                iconSize: 40,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Notifications()));
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MessageBox()));
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xCBFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: sampleMarkets
              .map((post) => MarketCard(
                    addToBasket: () {
                      addToBasket(post);
                    },
                    post: post,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
