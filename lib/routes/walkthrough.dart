import 'package:cs310_group_28/routes/welcome.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class WalkThrough extends StatefulWidget {
  const WalkThrough({Key? key}) : super(key: key);

  @override
  State<WalkThrough> createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {


  int currentIndex = 0;
  bool isLastPage = false;

  final controller = PageController(initialPage: 0);


  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  _storeWalkthroughInfo() async {
    int isViewed =0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("walkthrough", isViewed);
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "WELCOME",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "to walkthrough click next to start.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.mainTextColor,
                          fontSize: 30,
                          fontWeight: FontWeight.normal
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
                  children:  [
                   Icon(
                     Icons.home_outlined,
                     color: Colors.blueAccent,
                     size: 150,
                   ),
                    Text(
                      "FEED",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "You can view your friendss' posts, like and comment to these posts.",
                          textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal
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
                children:  [
                  Icon(
                    Icons.account_circle_outlined,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "PROFILE",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can view and edit your profile.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal
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
                children:  [
                  Icon(
                    Icons.storefront_outlined,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "MARKET",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can buy and sell things in the market.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal
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
                children:  [
                  Icon(
                    Icons.search,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "SEARCH",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can search people, tags, items and locations.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal
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
                children:  [
                  Icon(
                    Icons.forum_outlined,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "MESSAGE BOX",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can message to your friends.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal
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
                children:  [
                  Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.blueAccent,
                    size: 150,
                  ),
                  Text(
                    "NOTIFICATION TAB",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "You can check your notifications in notification tab.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.mainTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage ? TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0)
          ),
          primary: Colors.white,
          backgroundColor: Colors.blueAccent,
          minimumSize: const Size.fromHeight(80)
        ),
          onPressed: (){
            _storeWalkthroughInfo();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Welcome()));
          },
          child: const Text('Get Started',
          style: TextStyle(fontSize: 24),
          )
      )
      : Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        height: 80,
        color: Colors.white70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () => controller.jumpToPage(2),
                child: Text('SKIP')
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 7,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.blueAccent,
                ),
                onDotClicked: (index) => controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn),
              ),
            ),
            Spacer(),
            TextButton(
            child: Text('NEXT'),
              onPressed: () => controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
            ),
          ],
        ),
      ),


    );
  }
}


