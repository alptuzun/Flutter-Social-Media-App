import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import '../visuals/text_style.dart';
import 'explore_user_profile.dart';

class user_followers extends StatefulWidget {
  const user_followers({Key? key}) : super(key: key);

  @override
  State<user_followers> createState() => _user_followersState();
}

class _user_followersState extends State<user_followers> {
  List<MyUser> _foundUsers = [];
  List<MyUser> list_of_users = [];
  //List followers = [];
  List followings = [];
  bool isFollowing = false;
  final TextEditingController searchcontrol = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    TextEditingController().dispose();
  }

  @override
  void initState() {
    super.initState();
    prt();
    getUsersFollowers();
    //handleFollowUser();
  }

  isfollows(dynamic user_id) async {
    var result = await UserService.isFollowing(
        uid: FirebaseAuth.instance.currentUser!.uid, followingUserID: user_id);
    setState(() {
      isFollowing = result;
    });
  }

  Future getUsersFollowers() async {
    var user =
        await UserService.getFollowings(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      followings = user;
    });
  }

  Future updateFollowing() async {
    List list =
        await UserService.getFollowings(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      followings = list;
    });
  }

  Future prt() async {
    List<MyUser> users = await UserService.getAllUsers();
    setState(() {
      _foundUsers = users;
      list_of_users = users;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundUsers = list_of_users
          .where((element) => element.fullName.toLowerCase().contains(search))
          .toList();
    });
  }

  userRemoveWithIndex(int whichUser) {
    setState(() {
      _foundUsers.removeAt(whichUser);
    });
  }

  bool usershowing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
              splashRadius: 27,
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 34,
              ),
              color: AppColors.titleColor,
              onPressed: () {
                Navigator.pop(context); // pop the context
              }),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Followers',
            style: Styles.appBarTitleTextStyle,
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future:
              UserService.getFollowers(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text("User has no followers."));
            }
            return Container(
              color: const Color.fromARGB(255, 245, 245, 245),
              child: ListView.builder(
                itemCount: (snapshot.data! as dynamic).length,
                itemBuilder: (ctx, index) {
                  return userPart(
                      aUser: (snapshot.data! as dynamic)[index], index: 0);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  userPart({required dynamic aUser, required int index}) {
    return InkWell(
      splashColor: const Color(0xEEC60744),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExploreUserProfile(userID: aUser)));
      },
      child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Users')
              .where('userID', isEqualTo: aUser)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: CachedNetworkImageProvider(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['profilePicture']),
                            ),
                          )),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              (snapshot.data! as dynamic).docs[index]
                                  ['username'],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 15, 15, 15),
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              (snapshot.data! as dynamic).docs[index]
                                  ['username'],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 90, 90, 90))),
                        ],
                      )
                    ]),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          user_try_following(aUser);
                        });
                      },
                      child: AnimatedContainer(
                        height: 35,
                        width: 110,
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                            color: (followings.contains(
                              (snapshot.data! as dynamic).docs[index]
                                  ['username'],
                            ))
                                ? Colors.blue[700]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: Colors.transparent,
                                // if statement
                                width: 1)),
                        child: const Center(
                          child: Text(
                            'Remove',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    )
                  ],
                ));
          }),
    );
  }

  void user_try_following(dynamic aUser) async {
    await UserService.unFollow(
      FirebaseAuth.instance.currentUser!.uid,
      aUser,
    );
    await updateFollowing();
  }

  Future<String> givePicture(dynamic id) async {
    return await UserService.getProfilePicture(id);
  }
}
