import 'package:cached_network_image/cached_network_image.dart';
import 'package:cs310_group_28/routes/welcome.dart';
import 'package:cs310_group_28/services/auth.dart';
import 'package:cs310_group_28/visuals/alerts.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:provider/provider.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key, required this.user}) : super(key: key);
  static const String routeName = "user_settings";
  final MyUser user;

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final AuthService _auth = AuthService();
  bool change = false;
  String type = "";
  final _formKey = GlobalKey<FormState>();
  String input = "";
  final validCharacters = RegExp(r'^[a-zA-Z0-9_]+$');
  String oldPassword = "";

  void handlePrivateAccountToggle(bool val, String userID) {
    setState(() {
      UserService.setPrivate(widget.user, val, userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    analytics.logScreenView(
        screenClass: "UserSettings", screenName: "User's Settings Screen");
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
            if (change == true) {
              setState(() {
                change = false;
                type = "";
                input = "";
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        centerTitle: true,
        title: Text(
          "Settings",
          style: Styles.appBarTitleTextStyle,
        ),
      ),
      body: change == false
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
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
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            change = true;
                            type = "Please enter your preferred new username";
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.all(3),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child:
                                  Icon(Icons.account_circle_outlined, size: 35),
                            ),
                            Text(
                              "Change username",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            change = true;
                            type = "Please enter your Bio";
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.all(3),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.edit, size: 35),
                            ),
                            Text(
                              "Edit your Bio",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            change = true;
                            type = "Please enter your preferred new password";
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.all(3),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
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
                    ),
                    Container(
                      color: Colors.white,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            change = true;
                            type =
                                "Please enter your preferred new email address";
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.all(3),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
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
                    ),
                    Container(
                      color: Colors.white,
                      width: screenWidth(context),
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(5.0),
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
                            value: widget.user.private,
                            onChanged: (value) {
                              handlePrivateAccountToggle(value, user!.uid);
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 40),
                    ),
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
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.all(3),
                        ),
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
                    ),
                    Container(
                      color: Colors.white,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.all(3),
                        ),
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
                    ),
                    Container(
                      color: Colors.white,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.all(3),
                        ),
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
                    ),
                    Container(
                      color: Colors.white,
                      width: screenWidth(context),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.all(3),
                        ),
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
                      ),
                    ),
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
                        if (!mounted) {
                          return;
                        }
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Welcome()),
                            (r) => false);
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: screenWidth(context) / 100 * 5,
                                backgroundImage: CachedNetworkImageProvider(
                                    widget.user.profilePicture),
                              ),
                            ),
                            Text(
                              "Log Out of ${widget.user.username}",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff012169)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 9),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            child: TextFormField(
                              style: Styles.appMainTextStyle,
                              decoration: InputDecoration(
                                hintText: type,
                                hintStyle: Styles.appMainTextStyle,
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                              onFieldSubmitted: (value) async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (type ==
                                      "Please enter your preferred new email address") {
                                    await user?.updateEmail(input);
                                    if (!mounted) {
                                      return;
                                    }
                                    Alerts.showAlert(context, "Email Update",
                                        "Your email has been successfully updated");
                                  } else if (type ==
                                      "Please enter your preferred new password") {
                                    try {
                                      await user?.reauthenticateWithCredential(
                                          EmailAuthProvider.credential(
                                              email: user.email!,
                                              password: oldPassword));
                                    } on FirebaseAuthException catch (e) {
                                      Alerts.showAlert(
                                          context,
                                          "Update Password Error",
                                          e.toString());
                                    }
                                    await user?.updatePassword(value);
                                    if (!mounted) {
                                      return;
                                    }
                                    Alerts.showAlert(context, "Password Update",
                                        "Your password has been successfully updated");
                                  } else if (type ==
                                      "Please enter your preferred new username") {
                                    var result =
                                        await UserService.uniqueUsername(input);
                                    if (!mounted) {
                                      return;
                                    }
                                    if (!result) {
                                      Alerts.showAlert(
                                          context,
                                          "New Username Fail",
                                          "Your new username already exists in the database, please select another username");
                                    } else {
                                      await UserService.editUsername(
                                          user!.uid, input);
                                      if (!mounted) {
                                        return;
                                      }
                                      Alerts.showAlert(
                                          context,
                                          "Username Update",
                                          "Your username has been successfully updated");
                                    }
                                  } else {
                                    await UserService.editBio(user!.uid, input);
                                    if (!mounted) {
                                      return;
                                    }
                                    Alerts.showAlert(context, "Bio Update",
                                        "Your bio has been successfully updated");
                                  }
                                  setState(() {
                                    change = false;
                                    type = "";
                                    input = "";
                                    oldPassword = "";
                                  });
                                }
                              },
                              onSaved: (value) {
                                input = value ?? "";
                              },
                              validator: (value) {
                                if (type ==
                                    "Please enter your preferred new email address") {
                                  if (value != null) {
                                    if (value.isEmpty) {
                                      return "Cannot leave new email empty";
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      return "Please enter a valid email address";
                                    }
                                  }
                                  return null;
                                } else if (type ==
                                    "Please enter your preferred new password") {
                                  if (value != null) {
                                    if (value.isEmpty) {
                                      return 'Cannot leave password empty';
                                    }
                                    if (value.length < 6) {
                                      return 'Password too short';
                                    }
                                  }
                                  return null;
                                } else if (type ==
                                    "Please enter your preferred new username") {
                                  if (value != null) {
                                    if (value.isEmpty) {
                                      return "Cannot leave username empty";
                                    } else if (!validCharacters
                                        .hasMatch(value)) {
                                      return "Please enter a proper username";
                                    }
                                  }
                                  return null;
                                } else {
                                  if (value != null) {
                                    if (value.isEmpty) {
                                      return "Cannot leave the new bio empty";
                                    }
                                  }
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        if (type == "Please enter your preferred new password")
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              child: TextFormField(
                                style: Styles.appMainTextStyle,
                                decoration: InputDecoration(
                                  hintText: "Please enter your old password",
                                  hintStyle: Styles.appMainTextStyle,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                                onFieldSubmitted: (value) async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    try {
                                      await user?.reauthenticateWithCredential(
                                          EmailAuthProvider.credential(
                                              email: user.email!,
                                              password: oldPassword));
                                    } on FirebaseAuthException catch (e) {
                                      Alerts.showAlert(
                                          context,
                                          "Update Password Error",
                                          e.toString());
                                    }
                                    await user?.updatePassword(value);
                                    if (!mounted) {
                                      return;
                                    }
                                    Alerts.showAlert(context, "Password Update",
                                        "Your password has been successfully updated");
                                    setState(() {
                                      change = false;
                                      type = "";
                                      input = "";
                                      oldPassword = "";
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  oldPassword = value ?? "";
                                },
                                validator: (value) {
                                  if (value != null) {
                                    if (value.isEmpty) {
                                      return 'Cannot leave password empty';
                                    } else if (value.length < 6) {
                                      return 'Password too short';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}