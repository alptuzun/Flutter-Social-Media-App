import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/routes/user_followers.dart';
import 'package:cs310_group_28/routes/user_following.dart';
import 'package:cs310_group_28/services/post_service.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/ui/postcard.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cs310_group_28/visuals/colors.dart';

class ExploreUserProfile extends StatefulWidget {
  const ExploreUserProfile({Key? key, required this.userID}) : super(key: key);

  static const routeName = 'user_profile';
  final String userID;

  @override
  State<ExploreUserProfile> createState() => _ExploreUserProfileState();
}

class _ExploreUserProfileState extends State<ExploreUserProfile> {
  String currentSection = "Posts";
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static const List<String> sections = ["Posts"];
  String username = "";
  MyUser currentUser =
      MyUser(username: "", fullName: "", email: "", userID: "");

  getUserInfo() async {
    final postsRef = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.userID)
        .withConverter(
          fromFirestore: MyUser.fromFirestore,
          toFirestore: (MyUser currentUser, _) => currentUser.toFirestore(),
        )
        .get();
    var currentUser = postsRef.data()!;
    List<Post> userPosts = await currentUser.posts;
    List<Post> favoritePosts = await currentUser.favorites;
    List<MyUser> followers = await currentUser.followers;
    List<MyUser> following = await currentUser.following;
    return {
      "currentUser": currentUser,
      "posts": userPosts,
      "favorites": favoritePosts,
      "followers": followers,
      "following": following
    };
  }

  Future getUser() async {
    var user = await UserService.getUser(widget.userID);
    setState(() {
      username = user.username;
    });
  }

  Column infoColumnFollows(int number, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(number.toString(), style: const TextStyle(fontSize: 18)),
        TextButton(
            onPressed: () {
              if (text == "Followers") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserFollowers()));
              } else if (text == "Following") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserFollowing()));
              }
            },
            child: Text(text,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87))),
      ],
    );
  }

  @override
  void initState() {
    getUser();
    getUserInfo();
    super.initState();
  }

  Container notFound(String section, BuildContext context) {
    return Container(
      color: Colors.grey,
      width: screenWidth(context),
      child: SizedBox(
        height: screenHeight(context) * 0.65,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.cancel, color: Colors.black38, size: 60),
          Text("This user has no $section."),
        ]),
      ),
    );
  }

  Container priv(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: screenWidth(context),
      child: SizedBox(
        height: screenHeight(context) * 0.65,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.cancel, color: Colors.black38, size: 60),
              Text("This user's account is private"),
            ]),
      ),
    );
  }

  Widget posts(MyUser currentUser, BuildContext context, List<Post> posts) {
    if (currentUser.private == true) {
      return priv(context);
    } else {
      if (posts.isNotEmpty) {
        return Column(
            children: posts.reversed
                .map((post) => PostCard(
                    isOwner: false,
                    userID: post.userID,
                    realPost: post,
                    likes: () {
                      PostService.likePost(currentUser.userID, post.postID!);
                    },
                    dislikes: () {
                      PostService.dislikePost(currentUser.userID, post.postID!);
                    }))
                .toList());
      }
      return notFound("posts", context);
    }
  }


  Widget content(
      MyUser currentUser, List<Post> userPosts) {
    List<Widget> choices = [
      posts(currentUser, context, userPosts),
    ];
    return choices[sections.indexOf(currentSection)];
  }

  Expanded section(String label) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            currentSection = label;
          });
        },
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.black,
              fontWeight:
              currentSection == label ? FontWeight.w600 : FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    analytics.logScreenView(
        screenClass: "UserProfile", screenName: "User's Profile Screen");
    final user = Provider.of<User?>(context);
    return FutureBuilder(
        future: getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: SizedBox(
                    width: screenWidth(context),
                    height: screenHeight(context, dividedBy: 5),
                    child: const Center(child: CircularProgressIndicator())),
              ),
            );
          }
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
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                snapshot.data["currentUser"].username ?? "",
                style: Styles.appBarTitleTextStyle,
              ),
            ),
            backgroundColor: const Color(0xCBFFFFFF),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .snapshots()
                  .asBroadcastStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> querySnapshot) {
                if (!querySnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10),
                                        child: InkWell(
                                          onTap: () => showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AlertDialog(
                                                  contentPadding:
                                                  EdgeInsets.zero,
                                                  elevation: 0,
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  content: CircleAvatar(
                                                    radius: screenWidth(
                                                        context) /
                                                        3,
                                                    backgroundImage:
                                                    CachedNetworkImageProvider(snapshot
                                                        .data[
                                                    "currentUser"]
                                                        .profilePicture),
                                                  ),
                                                ),
                                          ),
                                          child: CircleAvatar(
                                            radius: 60,
                                            backgroundImage:
                                            CachedNetworkImageProvider(
                                                snapshot
                                                    .data[
                                                "currentUser"]
                                                    .profilePicture),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceAround,
                                          children: [
                                            const Spacer(),
                                            infoColumnFollows(
                                                snapshot
                                                    .data["posts"].length,
                                                "Posts"),
                                            const Spacer(),
                                            infoColumnFollows(
                                                snapshot.data["followers"]
                                                    .length,
                                                "Followers"),
                                            const Spacer(),
                                            infoColumnFollows(
                                                snapshot.data["following"]
                                                    .length,
                                                "Following"),
                                            const Spacer(),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                        snapshot
                                            .data["currentUser"].fullName,
                                        textScaleFactor: 0.8,
                                        style: Styles.boldTitleTextStyle),
                                  ),
                                  if (snapshot
                                      .data["currentUser"].bio.isNotEmpty)
                                    Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 15),
                                        child: Text(
                                          snapshot
                                              .data["currentUser"].bio,
                                          style: Styles.appMainTextStyle,
                                        )),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0),
                            child: Row(
                              children: [
                                for (final sec
                                in sections.asMap().entries) ...[
                                  section(sec.value),
                                  if (sec.key != sections.length - 1)
                                    const VerticalDivider(
                                      color: Colors.black38,
                                      thickness: 2,
                                      indent: 5,
                                      endIndent: 5,
                                    ),
                                ]
                              ],
                            ),
                          ),
                        ),
                        content(
                            snapshot.data["currentUser"],
                            snapshot.data["posts"],)
                      ],
                    ),
                  );
                }
              },
            )
          );
        });
  }

  void tryFollowing(dynamic aUser) async {
    await UserService.followUser(
      FirebaseAuth.instance.currentUser!.uid,
      aUser,
    );
  }
}
