import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);
  static const routeName = "/add_item";

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment. center,
        children: [
          Container(
            width: screenWidth(context) / 100 * 50 ,
            height: (screenHeight(context) / 100) * 5.5,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment(0, -1),
                  end: Alignment(0, 0),
                  colors: [
                    Colors.lightBlue,
                    Colors.lightBlueAccent
                  ]),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              child: ElevatedButton(
                onPressed: ()  {
                  null;
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Text(
                  "Add a Image",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth(context) / 100 * 50 ,
            height: (screenHeight(context) / 100) * 5.5,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment(0, -1),
                  end: Alignment(0, 0),
                  colors: [
                    Colors.lightBlue,
                    Colors.lightBlueAccent
                  ]),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              child: ElevatedButton(
                onPressed: ()  {
                  null;
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Text(
                  "Add a Image",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
