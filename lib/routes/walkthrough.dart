import 'package:cs310_group_28/models/shared_preferences.dart';
import 'package:cs310_group_28/routes/welcome.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalkThrough extends StatefulWidget {
  const WalkThrough({Key? key}) : super(key: key);

  @override
  State<WalkThrough> createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  int currentIndex = 0;
  bool isLastPage = false;

  final controller = PageController(initialPage: 0);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    analytics.logTutorialBegin();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 6);
          },
          children: [
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "WELCOME",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 40)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      "To walkthrough click next to start",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColors.mainTextColor,
                          fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.home_outlined,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "FEED",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 28)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can view your friends' posts, like and comment to these posts.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "PROFILE",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 28)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can view and edit your profile.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.storefront_outlined,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "MARKET",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 28)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can buy and sell things in the market.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "SEARCH",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 28)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can search people, tags, items and locations.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.forum_outlined,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "MESSAGE BOX",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 28)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can message to your friends, check for any information on the listed items.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "NOTIFICATION TAB",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 28)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can check your notifications in notification tab via the upper-left corner button."
                      " You can also update your notification preferences",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  primary: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: () {
                MySharedPreferences.instance.setBooleanValue("initialLoad", true);
                analytics.logTutorialComplete();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Welcome()));
              },
              child: Text(
                'Get Started',
                style: GoogleFonts.poppins(fontSize: 24),
              ))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              height: 80,
              color: Colors.white70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(6),
                      child: Text('SKIP',
                      style: GoogleFonts.poppins(),)),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 7,
                      effect: const WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.blueAccent,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    child: Text('NEXT',
                    style: GoogleFonts.poppins(),),
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    }
                  ),
                ],
              ),
            ),
    );
  }
}
