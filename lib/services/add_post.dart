import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cs310_group_28/services/camera.dart';
import 'package:cs310_group_28/visuals/alerts.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

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

  Future pickImage() async {
    try {
      XFile? galleryImage = await picker.pickImage(source: ImageSource.gallery);
      if (galleryImage != null) {
        var imageRoute = File(galleryImage.path);
        setState (() {
          image = imageRoute;
        });
      }
    } catch (e) {
      FirebaseCrashlytics.instance.log(e.toString());
    }
  }

  Future loadCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras[0];
    if (!mounted) {
      return;
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera) ));
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
                    Alerts.showOptions(context, "Add an Image", "Please select an option", " Choose a picture ", " Take a picture ", pickImage, loadCamera);
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
                    null;
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
