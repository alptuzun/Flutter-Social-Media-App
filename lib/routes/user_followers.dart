import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import '../visuals/colors.dart';
import '../visuals/text_style.dart';
import 'explore_user_profile.dart';

class user_followers extends StatefulWidget {
  const user_followers({Key? key}) : super(key: key);

  @override
  State<user_followers> createState() => _user_followersState();
}

class _user_followersState extends State<user_followers> {
  List<MyUser> followers = [];
  Map<String, bool> userFollowsFollower = {};
  final TextEditingController searchControl = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    TextEditingController().dispose();
  }

  Future<Map<String, dynamic>> getData() async {
    List<MyUser> followers =
        await UserService.getFollowers(FirebaseAuth.instance.currentUser!.uid);
    Map<String, bool> userFollowsFollower = {};
    for (MyUser follower in followers) {
      userFollowsFollower[follower.userID] = await UserService.userFollowsUser(
          FirebaseAuth.instance.currentUser!.uid, follower.userID);
    }
    return {"followers": followers, "userFollowsFollower": userFollowsFollower};
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Followers',
            style: Styles.appBarTitleTextStyle,
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: getData(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (!snapshot.hasData || snapshot.data!["followers"].isEmpty) {
              return const Center(child: Text("User has no followers."));
            }
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                followers = snapshot.data!["followers"];
                userFollowsFollower = snapshot.data!["userFollowsFollower"];
              });
            });

            return Container(
              color: const Color.fromARGB(255, 245, 245, 245),
              child: ListView.builder(
                itemCount: followers.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    splashColor: const Color(0xEEC60744),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExploreUserProfile(
                                  userID: followers[index].userID)));
                    },
                    child: FutureBuilder<MyUser>(
                        future: UserService.getUser(followers[index].userID),
                        builder: (context, AsyncSnapshot<MyUser> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CircleAvatar(
                                            radius: 60,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              (snapshot.data!.profilePicture),
                                            ),
                                          )),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!.username,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 15, 15, 15),
                                                fontWeight: FontWeight.w700)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(snapshot.data!.username,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 90, 90, 90))),
                                      ],
                                    )
                                  ]),
                                  GestureDetector(
                                    onTap: () async {
                                      if (userFollowsFollower[
                                          snapshot.data!.userID]!) {
                                        userFollowsFollower[
                                            snapshot.data!.userID] = false;
                                        await UserService.unFollow(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            followers[index].userID);
                                      } else {
                                        userFollowsFollower[
                                            snapshot.data!.userID] = true;
                                        await UserService.followUser(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            followers[index].userID);
                                      }
                                    },
                                    child: AnimatedContainer(
                                      height: 35,
                                      width: 110,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      child: Center(
                                        child: userFollowsFollower[
                                                snapshot.data!.userID]!
                                            ? const Text(
                                                'Remove',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                            : const Text(
                                                "Follow",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                      ),
                                    ),
                                  )
                                ],
                              ));
                        }),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
