import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/services/camera.dart';
import 'package:cs310_group_28/services/post_service.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/visuals/alerts.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);
  static const routeName = "/add_item";

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? image;
  File? video;
  ImagePicker picker = ImagePicker();
  String caption = "";
  static final List<List<String>> tags = [
    ["Theatre", "🎭"],
    ["Chess", "♔"],
    ["Film Producing", "🎬"],
    ["Philosophy", "🤔"],
    ["Cycling", "🚵‍"],
    ["Gastronomy", "🌮"],
    ["Psychology", "👩‍"],
    ["Golf", "⛳️"],
    ["Diving", "🤿"],
    ["Music", "🎸"],
    ["Gender", "🏳️‍🌈"]
  ];
  List<bool> tagsSelected = List<bool>.filled(tags.length, false);

  List<String> _getSelectedTags() {
    List<String> res = <String>[];
    for (int i = 0; i < tagsSelected.length; i++) {
      if (tagsSelected[i]) {
        res.add(tags[i][0]);
      }
    }
    return res;
  }

  Future<void> loadCamera(context) async {
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

  Future<void> pickVideo(context) async {
    try {
      XFile? galleryVideo = await picker.pickVideo(source: ImageSource.gallery);
      if (galleryVideo != null) {
        var videoRoute = File(galleryVideo.path);
        setState(() {
          video = videoRoute;
        });
      }
    } catch (e) {
      FirebaseCrashlytics.instance.log(e.toString());
    }
  }

  Future<List<dynamic>> getUser(String userID) async {
    MyUser user = await UserService.getUser(userID);
    List<Post> posts = await user.posts;
    return [user, posts];
  }

  Future<void> pickImage(context) async {
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

  Widget mediaPicker({required BuildContext context, required String userID}) {
    return Container(
      width: screenWidth(context),
      height: 60,
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      loadCamera(context);
                    },
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      pickImage(context);
                    },
                    child: const Icon(
                      Icons.image_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      pickVideo(context);
                    },
                    child: const Icon(
                      Icons.video_camera_back_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor:
                    MaterialStateColor.resolveWith((states) => Colors.white30),
              ),
              onPressed: () async {
                Post newPost = Post(
                    postTime: DateTime.now(),
                    userID: userID,
                    caption: caption,
                    tags: _getSelectedTags());
                String postID = await PostService.publishPost(newPost);
                if ((image ?? video) != null) {
                  await PostService.uploadToFirebaseImage(
                      userID, (image ?? video)!, postID);
                }
                Navigator.pop(context);
              },
              child: const Text(
                "Post",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User?>(context);

    return FutureBuilder(
      future: getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.blueAccent,
              backgroundColor: Colors.white,
            )),
          );
        } else {
          MyUser user = snapshot.data![0];
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  splashRadius: 27,
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 34,
                  ),
                  color: AppColors.titleColor,
                  onPressed: () {
                    Navigator.pop(context); // pop the context
                  }),
              backgroundColor: Colors.white,
              title: Text(
                "Add Photos & Video or Post",
                style: Styles.appBarTitleTextStyle,
              ),
              centerTitle: true,
            ),
            backgroundColor: const Color(0xCBFFFFFF),
            body: SafeArea(
              child: Container(
                  color: Colors.white,
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 8, right: 8),
                                child: Column(
                                  children: [
                                    if ((image ?? video) != null)
                                      SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 5 / 4),
                                          child: Image.file(
                                              image != null ? image! : video!)),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 8),
                                      alignment: Alignment.center,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(children: [
                                            for (int i = 0;
                                                i < tags.length;
                                                i++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: InputChip(
                                                  label: Text(tags[i][0]),
                                                  labelStyle: const TextStyle(
                                                      fontSize: 16),
                                                  avatar: Text(
                                                    tags[i][1],
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  elevation: 3,
                                                  backgroundColor:
                                                      Colors.white70,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  selected: tagsSelected[i],
                                                  onPressed: () {
                                                    setState(() {
                                                      tagsSelected[i] =
                                                          !tagsSelected[i];
                                                    });
                                                  },
                                                ),
                                              ),
                                          ])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        bottom: 10,
                                      ),
                                      child: TextField(
                                        autofocus: true,
                                        minLines: 1,
                                        maxLines: 4,
                                        onChanged: (value) {
                                          setState(() {
                                            caption = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "Add your caption",
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 14),
                                            border: InputBorder.none),
                                        autocorrect: false,
                                        textInputAction: TextInputAction.send,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            mediaPicker(
                                context: context, userID: currentUser.uid),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          );
        }
      },
    );
  }
}
