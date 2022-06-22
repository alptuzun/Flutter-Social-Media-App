import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';
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
  String username = "";
  MyUser currentUser =
      MyUser(username: "", fullName: "", email: "", userID: "");
  late List<Post> _posts;

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
    var user = await UserService.getUser(widget.userID);
    setState(() {
      username = user.username;
    });
  }

  Future<void> getPosts() async {
    List<Post> posts = await currentUser.posts;
    setState(() {
      _posts = posts;
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
                        builder: (context) => const user_followers()));
              } else if (text == "Following") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const user_following()));
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
    getPosts();
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

  Widget posts(MyUser currentUser, BuildContext context) {
    if (currentUser.private == true) {
      return priv(context);
    } else {
      if (_posts.isNotEmpty) {
        return Column(
            children: _posts.reversed
                .map((post) => PostCard(
                    isOwner: false,
                    userID: post.userID,
                    realPost: post,
                    likes: () {},
                    dislikes: () {}))
                .toList());
      }
      return notFound("posts", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    analytics.logScreenView(
        screenClass: "UserProfile", screenName: "User's Profile Screen");
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
                                            _posts.length, "Posts"),
                                        const Spacer(),
                                        infoColumnFollows(0, "Followers"),
                                        const Spacer(),
                                        infoColumnFollows(0, "Following"),
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
                              if (currentUser.bio.isNotEmpty)
                                const SizedBox(
                                  height: 5,
                                ),
                              Center(
                                child: FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('userID',
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser!.uid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            user_try_following(
                                                currentUser.userID);
                                          });
                                        },
                                        child: AnimatedContainer(
                                          height: 35,
                                          width: 110,
                                          duration:
                                              const Duration(milliseconds: 250),
                                          decoration: BoxDecoration(
                                              color:
                                                  ((snapshot.data! as dynamic)
                                                          .docs[0]['following']
                                                          .contains(
                                                            currentUser.userID,
                                                          ))
                                                      ? Colors.blue[700]
                                                      : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              border: Border.all(
                                                  color: ((snapshot.data!
                                                              as dynamic)
                                                          .docs[0]['following']
                                                          .contains(currentUser
                                                              .userID))
                                                      ? Colors.transparent
                                                      : Colors.grey
                                                          .shade700, // if statement
                                                  width: 1)),
                                          child: Center(
                                            child: Text(
                                              (snapshot.data! as dynamic)
                                                      .docs[0]['following']
                                                      .contains(
                                                          currentUser.userID)
                                                  ? "Unfollow"
                                                  : "Follow",
                                              style: TextStyle(
                                                  color: (snapshot.data!
                                                              as dynamic)
                                                          .docs[0]['following']
                                                          .contains(currentUser
                                                              .userID)
                                                      ? Colors.white
                                                      : Colors.blue),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ]),
                      ),
                    ),
                    /*
                    SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [posts(currentUser, context)],
                        ),
                      ),
                    ),
                     */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Posts",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    posts(currentUser, context),
                  ],
                ),
              );
            }
          },
        ));
  }

  void user_try_following(dynamic aUser) async {
    await UserService.followUser(
      FirebaseAuth.instance.currentUser!.uid,
      aUser,
    );
  }
}
