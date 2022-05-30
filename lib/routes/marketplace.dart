import 'package:cs310_group_28/ui/marketcard.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';

import '../models/post.dart';
import '../models/user.dart';
import 'messages_screen.dart';
import 'notifications.dart';
List<Post> sampleMarkets = [
  Post(
    user: MyUser(
      username: "silaozinan",
      email: "silaozinan@sabanciuniv.edu",
      fullName: "Sıla Özinan",
    ),
    caption: "fridge for sale",
    date: "21 September 2021",
    location: "Sabancı University",
    imageName: 'assets/images/fridge.jpg',
    price: "2000 TL"
  ),
  Post(
    user: MyUser(
      username: "aliozgunakyuz",
      email: "akyuz@sabanciuniv.edu",
      fullName: "Ali Özgün Akyüz",
    ),
    caption: "couch (only used for one semester)",
    date: "17 November 2021",
    // likes: 488,
    // comments: 27,
    imageName: 'assets/images/couch.jpg',
    price:"1000 TL"
  ),
  Post(
    user: MyUser(
      username: "sermetozgu",
      email: "sermetozgu@sabanciuniv.edu",
      fullName: "Sermet Özgü",
    ),
    caption: "I'm selling TLL101 books",
    date: "27 May 2021",
    // likes: 1070897,
    //
    // comments: 7787,
    location: "Sabancı University",
    imageName: 'assets/images/books.jpg',
    price: "150 TL"
  ),
  Post(
    user: MyUser(
      username: "yasinalbayrak",
      email: "yasinalbayrak@sabanciuniv.edu",
      fullName: "Yasin Albayrak",
    ),
    caption: "Anyone want to buy a bike?",
    date: "16 May 2021",
    // likes: 247,
    //
    // comments: 12,
    imageName: "assets/images/bike.jpg",
    price: "90 €"
  )
];
class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

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
    analytics.logScreenView(screenClass: "MarketPlace", screenName: "Market Place");
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Notifications()));
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
