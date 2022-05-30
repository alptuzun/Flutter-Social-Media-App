import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/routes/notifications.dart';
import 'package:cs310_group_28/ui/postcard.dart';
import 'package:cs310_group_28/ui/profile_banner.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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

  static const List<String> sections = ["Posts", "Favorites", "Comments"];
  String currentSection = "Posts";
  MyUser mockUser = MyUser(
      username: "isiktantanis",
      fullName: "Işıktan Tanış",
      email: "isiktantanis@gmail.com");
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    mockUser.addPost(Post(
        user: mockUser,
        date: "27/05/2022",
        imageName: "assets/images/eloncar.jpg"));
    mockUser.addPost(Post(
        user: mockUser,
        date: "27/05/2022",
        imageName: "assets/images/eloncar.jpg"));
    mockUser.addPost(Post(
        user: mockUser,
        date: "27/05/2022",
        imageName: "assets/images/eloncar.jpg"));
    mockUser.addPost(Post(
        user: mockUser,
        date: "27/05/2022",
        imageName: "assets/images/eloncar.jpg"));
    mockUser.addPost(Post(
        user: mockUser,
        date: "27/05/2022",
        imageName: "assets/images/eloncar.jpg"));
    mockUser.addPost(Post(
        user: mockUser,
        date: "27/05/2022",
        imageName: "assets/images/eloncar.jpg"));
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
    if (mockUser.posts.isNotEmpty) {
      return Column(
          children: mockUser.posts
              .map((post) => PostCard(
                  post: post, comment: () {}, likes: () {}, dislikes: () {}))
              .toList());
    }
    return notFound("posts");
  }

  Widget favorites() {
    if (mockUser.favorites.isNotEmpty) {
      return Column(
          children: mockUser.favorites
              .map((post) => PostCard(
                  post: post, comment: () {}, likes: () {}, dislikes: () {}))
              .toList());
    }
    return notFound("favorites");
  }

  Widget comments() {
    if (mockUser.comments.isNotEmpty) {
      return Column(
          children: mockUser.comments
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
    analytics.logScreenView(screenClass: "UserProfile", screenName: "User's Profile Screen");
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
            mockUser.username,
            style: Styles.appBarTitleTextStyle,
          ),
        ),
        backgroundColor: const Color(0xCBFFFFFF),
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileBanner(user: mockUser),
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
        )));
  }
}
