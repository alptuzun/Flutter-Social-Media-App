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
  List<Post> posts = <Post>[];

  Future<Map<String, dynamic>> getData(String userID) async {
    Map<String, dynamic> data = {};
    var userInfo =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    data["user"] =
        MyUser.fromJson((userInfo.data() ?? Map<String, dynamic>.identity()));
    data["followers"] = await data["user"].followers;
    data["following"] = await data["user"].following;
    return data;
  }

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
      body: FutureBuilder<Map<String, dynamic>>(
        future: getData(user!.uid),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
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
              snapshot.data != null) {
            return StreamBuilder<List<Post>>(
                stream: FirebaseFirestore.instance
                    .collection('Posts')
                    .snapshots()
                    .map((event) => List<Post>.from(
                        event.docs.map((doc) => Post.fromFirestore(doc, null))))
                    .asBroadcastStream(),
                builder: (BuildContext context, s) {
                  if (!s.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    for (var currentPost in s.data!) {
                      if (!posts
                              .map((p) => p.postID)
                              .contains(currentPost.postID) &&
                          snapshot.data!["following"]
                              .map((u) => u.userID)
                              .contains(currentPost.userID)) {
                        posts.add(currentPost);
                        posts.sort((p1, p2) {
                          int valP1 = 0;
                          int valP2 = 0;
                          snapshot.data!["user"].interests.forEach((interest) {
                            if (p1.tags.contains(interest)) valP1 += 1;

                            if (p2.tags.contains(interest)) valP2 += 1;
                          });
                          if (snapshot.data!["followers"].contains(p1.userID)) {
                            valP1 += 1;
                          }
                          if (snapshot.data!["followers"].contains(p2.userID)) {
                            valP2 += 1;
                          }
                          if (p1.mediaURL != null) valP1++;
                          if (p2.mediaURL != null) valP2++;
                          return valP1.compareTo(valP2);
                        });
                      }
                    }
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.from(posts
                            .map((post) => PostCard(
                                  realPost: post,
                                  isOwner: post.userID ==
                                      snapshot.data!["user"].userID,
                                  userID: user.uid,
                                  likes: () {
                                    PostService.likePost(
                                        user.uid, post.postID!);
                                  },
                                  dislikes: () {
                                    PostService.dislikePost(
                                        user.uid, post.postID!);
                                  },
                                ))
                            .toList()),
                      ),
                    );
                  }
                });
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
