import 'package:cached_network_image/cached_network_image.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/services/post_service.dart';
import 'package:cs310_group_28/visuals/alerts.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditPost extends StatefulWidget {
  const EditPost({Key? key, required this.editedPost}) : super(key: key);
  final Post editedPost;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  String newCaption = "";

  @override
  Widget build(BuildContext context) {
    analytics.logScreenView(
        screenClass: "EditPost", screenName: "Post_Edit_Screen");
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
          splashRadius: 27,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColors.titleColor,
          iconSize: 40,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Edit Your Post",
          style: Styles.appBarTitleTextStyle,
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xCBFFFFFF),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(screenHeight(context) * 0.017),
              child: CachedNetworkImage(
                imageUrl: widget.editedPost.postURL,
                width: screenWidth(context) * 0.95,
                height: screenHeight(context) * 0.35,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
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
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    hintText: "Enter your caption",
                  ),
                  onChanged: (text) {
                    newCaption = text;
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
                    colors: [Colors.lightBlue, Colors.lightBlueAccent]),
                borderRadius: BorderRadius.circular(35),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                child: ElevatedButton(
                  onPressed: () async {
                    await PostService.editPost(
                        user!.uid, widget.editedPost.postID, newCaption);
                    if (!mounted) {
                      return;
                    }
                    await Alerts.showAlert(context, "Post Edit",
                        "Your post has been successfully changed");
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
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
          ])),
    );
  }
}
