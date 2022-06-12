import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/routes/marketplace.dart';
import 'package:cs310_group_28/routes/messages_screen.dart';
import 'package:cs310_group_28/routes/user_followers.dart';
import 'package:cs310_group_28/routes/user_following.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/ui/postcard.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExploreUserProfile extends StatefulWidget {
  const ExploreUserProfile({Key? key, required this.userID}) : super(key: key);

  static const routeName = 'user_profile';
  final String userID;

  @override
  State<ExploreUserProfile> createState() => _ExploreUserProfileState();
}

class _ExploreUserProfileState extends State<ExploreUserProfile> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  String username = "";
  MyUser currentUser =
      MyUser(username: "", fullName: "", email: "", userID: "");

  getUserInfo() async {
    final ref = FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.userID)
        .withConverter(
          fromFirestore: MyUser.fromFirestore,
          toFirestore: (MyUser currentUser, _) => currentUser.toFirestore(),
        );
    final docSnap = await ref.get();
    currentUser = docSnap.data()!;
  }

  Future getUser() async {
    var user = await UserService.getUsername(widget.userID);
    setState(() {
      username = user;
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
                        builder: (context) => const SearchListCard()));
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

  Container notFound(String section) {
    return Container(
      color: Colors.grey,
      width: screenWidth(context),
      child: SizedBox(
        height: 460,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.cancel, color: Colors.black38, size: 60),
          Text("This user has no $section."),
        ]),
      ),
    );
  }

  Widget posts(MyUser currentUser) {
    if (currentUser.posts.isNotEmpty) {
      List<Post> allPosts = [];
      for (int x = 0; x < currentUser.posts.length; x++) {
        Post newPost = Post.fromJson(currentUser.posts[x]);
        allPosts.add(newPost);
      }
      allPosts = List.from(allPosts.reversed);
      return Column(
          children: allPosts
              .map((post) => PostCard(
                  isOwner: true,
                  userID: post.userID,
                  post: post,
                  comment: () {},
                  likes: () {},
                  dislikes: () {}))
              .toList());
    }
    return notFound("posts");
  }

  Widget content(MyUser currentUser) {
    return posts(currentUser);
  }

  Expanded section(String label) {
    return Expanded(
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    analytics.logScreenView(
        screenClass: "UserProfile", screenName: "User's Profile Screen");
    final user = Provider.of<User?>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
            splashRadius: 27,
            color: Colors.grey,
            iconSize: 40,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: Text(
            username,
            style: Styles.appBarTitleTextStyle,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
              splashRadius: 27,
              icon: const Icon(Icons.report),
              color: Colors.grey,
              iconSize: 40,
            )
          ],
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
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.4)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: InkWell(
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          content: CircleAvatar(
                                            radius: screenWidth(context) / 3,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    currentUser.profilePicture),
                                          ),
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                currentUser.profilePicture),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Spacer(),
                                        infoColumnFollows(
                                            currentUser.posts.length, "Posts"),
                                        const Spacer(),
                                        infoColumnFollows(
                                            currentUser.followers.length,
                                            "Followers"),
                                        const Spacer(),
                                        infoColumnFollows(
                                            currentUser.following.length,
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
                                child: Text(currentUser.fullName,
                                    textScaleFactor: 0.8,
                                    style: Styles.boldTitleTextStyle),
                              ),
                              if (currentUser.bio.isNotEmpty)
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    child: Text(
                                      currentUser.bio,
                                      style: Styles.appMainTextStyle,
                                    )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MessageBox()));
                                          },
                                          icon: const Icon(Icons.forum),
                                          splashRadius: 31,
                                          iconSize: 35,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MarketPlace()));
                                          },
                                          icon: const Icon(Icons.storefront),
                                          splashRadius: 31,
                                          iconSize: 35,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [posts(currentUser)],
                        ),
                      ),
                    ),
                    content(currentUser),
                  ],
                ),
              );
            }
          },
        ));
  }
}
