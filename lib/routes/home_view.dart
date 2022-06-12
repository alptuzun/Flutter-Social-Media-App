import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/routes/messages_screen.dart';
import 'package:cs310_group_28/routes/notifications.dart';
import 'package:cs310_group_28/services/add_post.dart';
import 'package:cs310_group_28/services/post_service.dart';
import 'package:cs310_group_28/ui/postcard.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const String routeName = "/home_view";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.logScreenView(screenClass: "HomeView", screenName: "Main_Screen");
    final user = Provider.of<User?>(context);
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
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('Users').doc(user!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  Text(
                    "Oops, Something went very wrong right now",
                    style: Styles.appMainTextStyle,
                  ),
                ],
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.data() != null) {
            MyUser currentUser = MyUser.fromJson((snapshot.data!.data() ??
                Map<String, dynamic>.identity()) as Map<String, dynamic>);
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .snapshots()
                  .asBroadcastStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> querySnapshot) {
                if (!querySnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  List<dynamic> postsList = querySnapshot.data!.docs
                      .map((data) => (data["posts"]))
                      .toList();

                  List<dynamic> followingPosts = [];
                  for (int j = 0; j < postsList.length; j++) {
                    for (int k = 0; k < postsList[j].length; k++) {
                      followingPosts += [postsList[j][k]];
                    }
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.from(
                        followingPosts
                            .map((post) => PostCard(
                                  post: Post.fromJson(post),
                                  isOwner: post["userID"] == currentUser.userID,
                                  userID: user.uid,
                                  comment: () {},
                                  likes: () {
                                    PostService.likePost(user.uid,
                                        post["userID"], post["postID"]);
                                  },
                                  dislikes: () {
                                    PostService.dislikePost(user.uid,
                                        post["userID"], post["postID"]);
                                  },
                                ))
                            .toList()
                            .reversed,
                      ),
                    ),
                  );
                }
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
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
