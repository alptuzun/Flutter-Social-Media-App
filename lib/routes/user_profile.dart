import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/routes/notifications.dart';
import 'package:cs310_group_28/routes/user_settings.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/ui/profile_banner.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  static const routeName = 'user_profile';

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static const List<String> sections = ["Posts", "Favorites", "Comments"];
  String currentSection = "Posts";
  String username = "";
  MyUser currentUser = MyUser(username: "", fullName: "", email: "");

  getUserInfo() async {
    final ref = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .withConverter(
          fromFirestore: MyUser.fromFirestore,
          toFirestore: (MyUser currentUser, _) => currentUser.toFirestore(),
        );
    final docSnap = await ref.get();
    currentUser = docSnap.data()!;

  }

  Future getUser() async {
    var user =
        await UserService.getUsername(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      username = user;
    });
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
    if (!currentUser.posts.isNotEmpty) {
      /*return Column(
          children: currentUser.posts
              .map((post) => PostCard(
                  post: post, comment: () {}, likes: () {}, dislikes: () {}))
              .toList());*/
    }
    return notFound("posts");
  }

  Widget favorites(MyUser currentUser) {
    if (currentUser.favorites.isNotEmpty) {
      /*return Column(
          children: currentUser.favorites
              .map((post) => PostCard(
                  post: post, comment: () {}, likes: () {}, dislikes: () {}))
              .toList());*/
    }
    return notFound("favorites");
  }

  Widget comments(MyUser currentUser) {
    if (currentUser.comments.isNotEmpty) {
      /*return Column(
          children: currentUser.comments
              .map((post) => PostCard(
                  post: post, comment: () {}, likes: () {}, dislikes: () {}))
              .toList());*/
    }
    return notFound("comments");
  }

  Widget content(MyUser currentUser) {
    List<Widget> choices = [
      posts(currentUser),
      favorites(currentUser),
      comments(currentUser)
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
        centerTitle: true,
        actions: [
          IconButton(
            padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
            splashRadius: 27,
            icon: const Icon(Icons.menu_rounded),
            color: Colors.grey,
            iconSize: 40,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserSettings(user: currentUser)));
            },
          ),
        ],
        title: Text(
          username,
          style: Styles.appBarTitleTextStyle,
        ),
      ),
      backgroundColor: const Color(0xCBFFFFFF),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .snapshots()
            .asBroadcastStream(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
          if (!querySnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileBanner(user: currentUser),
                  SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          for (final sec in sections.asMap().entries) ...[
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
                  content(currentUser),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
