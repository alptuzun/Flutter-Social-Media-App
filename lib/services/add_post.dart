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

  Future pickImage() async {
    try {
      XFile? galleryImage = await picker.pickImage(source: ImageSource.gallery);
      if (galleryImage != null) {
        var imageRoute = File(galleryImage.path);
        setState(() {
          image = imageRoute;
          Navigator.of(context).pop();
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

  Future pickVideo() async {
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

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User?>(context);
    return FutureBuilder(
      future: UserService.returnRef().doc(currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.blueAccent,
              backgroundColor: Colors.white,
            )),
          );
        } else {
          MyUser user =
              MyUser.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          if (image != null || video != null || caption.isNotEmpty) {
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
                        if (video == null || image == null || caption == "@") {
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            image = null;
                            video = null;
                            caption = "";
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      }),
                  backgroundColor: Colors.white,
                  title: Text(
                    "Add Photos & Video or Post",
                    style: Styles.appBarTitleTextStyle,
                  ),
                  centerTitle: true,
                ),
                backgroundColor: const Color(0xCBFFFFFF),
                body: image != null
                    ? Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  screenHeight(context) * 0.017),
                              child: Image.file(
                                image!,
                                width: screenWidth(context) * 0.95,
                                height: screenHeight(context) * 0.35,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 3,
                                  style: Styles.appMainTextStyle,
                                  decoration: InputDecoration(
                                    hintStyle: Styles.appMainTextStyle,
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                    ),
                                    hintText: "Enter your caption",
                                  ),
                                  onChanged: (text) {
                                    caption = text;
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: (screenWidth(context) / 100) * 45,
                              height: (screenHeight(context) / 100) * 5.5,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment(0, -1),
                                    end: Alignment(0, 0),
                                    colors: [
                                      Colors.lightBlue,
                                      Colors.lightBlueAccent
                                    ]),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    String url =
                                        await PostService.uploadToFirebaseImage(
                                            currentUser,
                                            image!,
                                            (user.posts.length + 1).toString());
                                    Post newPost = Post(
                                      postTime: DateTime.now(),
                                      postID:
                                          (user.posts.length + 1).toString(),
                                      postURL: url,
                                      type: "image",
                                      username: user.username,
                                      fullName: user.fullName,
                                      userID: currentUser.uid,
                                      caption: caption,
                                      likes: [],
                                      comments: [],
                                      price: "-1",
                                      location: "",
                                      imageName: "",
                                      dislikes: [],
                                    );
                                    PostService.publishPost(
                                        currentUser.uid, newPost);
                                    setState(() {
                                      image = null;
                                      caption = "";
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: Text(
                                    "Post",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ]))
                    : video != null
                        ? const Center(
                            child: Text("Your video is ready to upload!"))
                        : Center(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 5),
                                  child: Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      minLines: 6,
                                      maxLines: 6,
                                      textAlign: TextAlign.center,
                                      style: Styles.appMainTextStyle,
                                      decoration: InputDecoration(
                                        hintStyle: Styles.appMainTextStyle,
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        hintText: "Enter your post text",
                                      ),
                                      onChanged: (text) {
                                        caption = text;
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: (screenWidth(context) / 100) * 45,
                                  height: (screenHeight(context) / 100) * 5.5,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: Alignment(0, -1),
                                        end: Alignment(0, 0),
                                        colors: [
                                          Colors.lightBlue,
                                          Colors.lightBlueAccent
                                        ]),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Post newPost = Post(
                                          postTime: DateTime.now(),
                                          postID:
                                          user.userID + (user.posts.length + 1).toString(),
                                          postURL: "None",
                                          type: "text",
                                          username: user.username,
                                          fullName: user.fullName,
                                          userID: currentUser.uid,
                                          caption: caption,
                                          likes: [],
                                          comments: [],
                                          price: "-1",
                                          location: "",
                                          imageName: "",
                                          dislikes: [],
                                        );
                                        PostService.publishPost(
                                            currentUser.uid, newPost);
                                        setState(() {
                                          caption = "";
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      child: Text(
                                        "Post",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ])));
          } else {
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
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 5,
                    ),
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
                          onPressed: () {
                            Alerts.showOptions(
                                context,
                                "Add an Image",
                                "Please select an option",
                                " Choose a picture ",
                                " Take a picture ",
                                pickImage,
                                loadCamera);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: Text(
                            "Add an Image",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
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
                          onPressed: pickVideo,
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: Text(
                            "Add a Video",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
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
                          onPressed: () {
                            setState(() {
                              caption = "@";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: Text(
                            "Add a Text Post",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
