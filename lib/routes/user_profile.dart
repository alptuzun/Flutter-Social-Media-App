import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/services/shared_preferences.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/routes/notifications.dart';
import 'package:cs310_group_28/ui/postcard.dart';
import 'package:cs310_group_28/ui/profile_banner.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

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
  MyUser currentUser = MyUser(username: "", fullName: "", email: "");

  getUserInfo() async {
    MySharedPreferences.instance
        .getBooleanValue("loggedIn")
        .then((loggedIn) => {if (loggedIn) {}});
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc("ww7kadAu7ccLNLKHrT4n9aygNWH3")
          .get()
          .then(
        (DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          setState(() {
            currentUser = MyUser(
                username: data["username"],
                fullName: data["fullName"],
                email: data["email"]);
          });
        },
        onError: (e) => print("Error getting document: ${e.toString()}"),
      );
    });
  }

  @override
  void initState() {
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

  Widget posts() {
    if (currentUser.posts.isNotEmpty) {
      return Column(
          children: currentUser.posts
              .map((post) => PostCard(
                  post: post, comment: () {}, likes: () {}, dislikes: () {}))
              .toList());
    }
    return notFound("posts");
  }

  Widget favorites() {
    if (currentUser.favorites.isNotEmpty) {
      return Column(
          children: currentUser.favorites
              .map((post) => PostCard(
                  post: post, comment: () {}, likes: () {}, dislikes: () {}))
              .toList());
    }
    return notFound("favorites");
  }

  Widget comments() {
    if (currentUser.comments.isNotEmpty) {
      return Column(
          children: currentUser.comments
              .map((post) => PostCard(
                  post: post, comment: () {}, likes: () {}, dislikes: () {}))
              .toList());
    }
    return notFound("comments");
  }

  Widget content() {
    List<Widget> choices = [posts(), favorites(), comments()];
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Notifications()));
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
                Navigator.pushNamed(context, "user_settings");
              },
            ),
          ],
          title: Text(
            currentUser.username,
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
                    content(),
                  ],
                ));
              }
            }));

    /*
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Users").snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
        if (!querySnapshot.hasData) {
          return const Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
        }
      },
    );
    */

    /* return Scaffold(
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Notifications()));
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
                Navigator.pushNamed(context, "user_settings");
              },
            ),
          ],
          title: Text(
            currentUser.username,
            style: Styles.appBarTitleTextStyle,
          ),
        ),
        backgroundColor: const Color(0xCBFFFFFF),
        body: SingleChildScrollView(
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
            content(),
          ],
        )));*/
  }
}
