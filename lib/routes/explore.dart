import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/functions/explore_tiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cs310_group_28/functions/custome_explorebar.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../services/post_service.dart';
import '../ui/postcard.dart';
import '../visuals/text_style.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  static const routeName = '/explore';

  @override
  State<Explore> createState() => _ExploreState();
  static String currValue = "Accounts";
}

class _ExploreState extends State<Explore> {
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

  List<Post> posts = <Post>[];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return FutureBuilder<Map<String, dynamic>>(
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
              snapshot.data != null &&
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
                        currentPost.mediaURL != null) {
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
                  return Container(
                    color: Colors.white,
                    child: SafeArea(
                        child: CustomScrollView(
                      slivers: [
                        const CustomExploreAppBar(),
                        SliverStaggeredGrid.countBuilder(
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                            crossAxisCount: 3,
                            staggeredTileBuilder: (int index) {
                              int moddedIndex = index % 20;
                              int cXCellcount = moddedIndex == 11 ? 2 : 1;
                              double mXCellCount = 1;
                              if (moddedIndex == 2 || moddedIndex == 11) {
                                mXCellCount = 2;
                              }
                              return StaggeredTile.count(
                                  cXCellcount, mXCellCount);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return ExploreTiles(post: posts[index]);
                            },
                            itemCount: posts.length)
                      ],
                    )),
                  );
                }
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
