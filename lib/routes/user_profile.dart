import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/routes/marketplace.dart';
import 'package:cs310_group_28/routes/messages_screen.dart';
import 'package:cs310_group_28/routes/notifications.dart';
import 'package:cs310_group_28/routes/user_followers.dart';
import 'package:cs310_group_28/routes/user_following.dart';
import 'package:cs310_group_28/routes/user_settings.dart';
import 'package:cs310_group_28/services/camera.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/ui/postcard.dart';
import 'package:cs310_group_28/visuals/alerts.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
  MyUser currentUser = MyUser(username: "", fullName: "", email: "", userID: "");
  bool photoOP = false;
  ImagePicker picker = ImagePicker();
  File? image;

  Future pickImage() async {
    try {
      XFile? galleryImage = await picker.pickImage(source: ImageSource.gallery);
      if (galleryImage != null) {
        var imageRoute = File(galleryImage.path);
        setState(() {
          image = imageRoute;
        });
      }
    } catch (e) {
      FirebaseCrashlytics.instance.log(e.toString());
    }
  }

  Future loadCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras[1];
    if (!mounted) {
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(camera: firstCamera)));
  }

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
                  realPost: post,
                  comment: () {},
                  likes: () {},
                  dislikes: () {}))
              .toList());
    }
    return notFound("posts");
  }

  Widget favorites(MyUser currentUser) {
    if (currentUser.favorites.isNotEmpty) {
      return Column(
          children: currentUser.favorites
              .map((post) => PostCard(
                  isOwner: true,
                  userID: post.userID,
                  realPost: post,
                  comment: () {},
                  likes: () {},
                  dislikes: () {}))
              .toList());
    }
    return notFound("favorites");
  }

  Widget comments(MyUser currentUser) {
    if (currentUser.comments.isNotEmpty) {
      return Column(
          children: currentUser.comments
              .map((post) => PostCard(
                  isOwner: true,
                  userID: post.userID,
                  realPost: post,
                  comment: () {},
                  likes: () {},
                  dislikes: () {}))
              .toList());
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
        leading: photoOP == false
            ? IconButton(
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
              )
            : IconButton(
                padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
                splashRadius: 27,
                icon: const Icon(Icons.arrow_back_ios_outlined),
                color: Colors.grey,
                iconSize: 40,
                onPressed: () {
                  setState(() {
                    photoOP = false;
                  });
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
      body: photoOP == false
          ? StreamBuilder<QuerySnapshot>(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Stack(children: [
                                          InkWell(
                                            onTap: () => showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                contentPadding: EdgeInsets.zero,
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: CircleAvatar(
                                                  radius:
                                                      screenWidth(context) / 3,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                          currentUser
                                                              .profilePicture),
                                                ),
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius: 60,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      currentUser
                                                          .profilePicture),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 1,
                                              right: 1,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 4,
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(50)),
                                                  color: Colors.white,
                                                ),
                                                child: Material(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(50)),
                                                  child: InkWell(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    splashColor: Colors.grey,
                                                    onTap: () {
                                                      setState(() {
                                                        photoOP = true;
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.add_a_photo,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ]),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Spacer(),
                                            infoColumnFollows(
                                                currentUser.posts.length,
                                                "Posts"),
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
                                              color:
                                                  Colors.white.withOpacity(0.5),
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
                                            color:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MarketPlace()));
                                              },
                                              icon:
                                                  const Icon(Icons.storefront),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth(context) / 100 * 80,
                    height: (screenHeight(context) / 100) * 8,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 0),
                          colors: [Colors.lightBlue, Colors.lightBlueAccent]),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: ElevatedButton(
                        onPressed: () async {
                          await pickImage();
                          if (image != null) {
                            await UserService.uploadNewPic(user, image!);
                            if (!mounted) {
                              return;
                            }
                            Alerts.showAlert(context, "Profile Picture Update",
                                "Your profile picture has been updated");
                            image = null;
                            photoOP = false;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: Text(
                          "Choose your picture",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
