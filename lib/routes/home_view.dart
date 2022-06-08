import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/routes/messages_screen.dart';
import 'package:cs310_group_28/routes/notifications.dart';
import 'package:cs310_group_28/services/add_post.dart';
import 'package:cs310_group_28/ui/postcard.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';

List<Post> samplePosts = [
  Post(
    postID: "1",
    postTime: DateTime.now(),
    userID: "2",
    user: MyUser(
      username: "alptuzun",
      email: "alptuzun@sabanciuniv.edu",
      fullName: "Alp Tüzün",
    ),
    caption: "Very Beautiful day in San Francisco",
    // likes: 505,
    // comments: 15,
    location: "Golden Gate Bridge",
    imageName: 'assets/images/goldengate.jpg',
  ),
  Post(
    postID: "1",
    postTime: DateTime.now(),
    userID: "2",
    user: MyUser(
      username: "isiktantanis",
      email: "isiktantanis@sabanciuniv.edu",
      fullName: "Işıktan Tanış",
    ),
    imageName: 'assets/images/andriod.jpg',
  ),
  Post(
    postID: "1",
    postTime: DateTime.now(),
    userID: "2",
    user: MyUser(
      username: "elonmusk",
      email: "elonmusk@sabanciuniv.edu",
      fullName: "Elon Musk",
    ),
    caption: "With my new Whip",
    location: "Tesla Inc. HQ",
    imageName: 'assets/images/eloncar.jpg',
  ),
  Post(
    postID: "1",
    postTime: DateTime.now(),
    userID: "2",
    user: MyUser(
      username: "yasinalbayrak",
      email: "yasinalbayrak@sabanciuniv.edu",
      fullName: "Yasin Albayrak",
    ),
    caption: "Live Like A Champion",
    imageName: "assets/images/muhammed_ali.jpg",
  )
];

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const String routeName = "/home_view";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void addComment(Post post) {
    setState(() {
      // post.comments++;
    });
  }

  void addLikes(Post post) {
    setState(() {
      // post.likes++;
    });
  }

  void addDislikes(Post post) {
    setState(() {
      // post.likes--;
    });
  }

  @override
  Widget build(BuildContext context) {
    analytics.logScreenView(screenClass: "HomeView", screenName: "Main_Screen");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
          splashRadius: 27,
          icon: const Icon(Icons.notifications_none_rounded),
          color: AppColors.titleColor,
          iconSize: 40,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Notifications()));
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
            color: AppColors.titleColor,
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
          children: samplePosts
              .map((post) => PostCard(
                    comment: () {
                      addComment(post);
                    },
                    likes: () {
                      addLikes(post);
                    },
                    dislikes: () {
                      addDislikes(post);
                    },
                    post: post,
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddPost()));
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
