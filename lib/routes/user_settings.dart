import 'package:cs310_group_28/routes/welcome.dart';
import 'package:cs310_group_28/util/auth.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:cs310_group_28/services/user_service.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);
  static const String routeName = "user_settings";

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  late MyUser mockUser;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void handlePrivateAccountToggle(bool val) {
    setState(() {
      UserService.setPrivate(mockUser, val);
    });
  }

  @override
  void initState() {
    super.initState();
    mockUser = MyUser(
        username: "isiktantanis",
        fullName: "Işıktan Tanış",
        email: "isiktantanis@gmail.com",
        private: true);
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    analytics.logScreenView(screenClass: "UserSettings", screenName: "User's Settings Screen");
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
            splashRadius: 27,
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.grey,
            iconSize: 40,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "Settings",
            style: Styles.appBarTitleTextStyle,
          ),
        ),
        body: (SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Profile",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.account_circle_outlined, size: 35),
                        ),
                        Text(
                          "Change username",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.password, size: 35),
                        ),
                        Text(
                          "Change password",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.email_outlined, size: 35),
                        ),
                        Text(
                          "Change email address",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: screenWidth(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.lock_outlined, size: 35),
                            ),
                            Text(
                              "Private account",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Switch(
                            value: mockUser.private,
                            onChanged: handlePrivateAccountToggle)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight(context, dividedBy: 40),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "General",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.info_outline, size: 35),
                          ),
                          Text(
                            "About",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.support, size: 35),
                          ),
                          Text(
                            "Help",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.privacy_tip_outlined, size: 35),
                          ),
                          Text(
                            "Privacy",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: screenWidth(context),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.language, size: 35),
                          ),
                          Text(
                            "Change language",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Accounts",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _auth.signOut();
                      if(!mounted) {
                        return;
                      }
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Welcome()),
                          (r) => false);
                    },
                    child: Container(
                      color: Colors.white,
                      child: Row(

                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage(mockUser.profilePicture),
                                minRadius: 17.5,
                              )),
                          Text(
                            "Log out of ${mockUser.username}",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff012169)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ))));
  }
}
