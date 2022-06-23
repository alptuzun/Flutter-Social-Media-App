import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/routes/page_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cs310_group_28/visuals/fade_animation.dart';
import 'package:cs310_group_28/visuals/colors.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/models/user.dart';
import 'explore_user_profile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const String routeName = "/explore_SearchScreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<MyUser> _foundUsers = [];
  List<MyUser> listOfUsers = [];

  //List followers = [];
  List followings = [];
  bool isFollowing = false;
  final TextEditingController searchControl = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    TextEditingController().dispose();
  }

  @override
  void initState() {
    prt();
    getUsersFollowers();
    super.initState();
    //handleFollowUser();
  }

  isfollows(dynamic userId) async {
    var result = await UserService.isFollowing(
        uid: FirebaseAuth.instance.currentUser!.uid, followingUserID: userId);
    setState(() {
      isFollowing = result;
    });
  }
  bool check(String id)
  {
    return isfollows(id);
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
      listOfUsers = users;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundUsers = listOfUsers
          .where((element) => element.username.toLowerCase().contains(search))
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
              title: SizedBox(
                height: 40,
                child: TextField(
                  controller: searchControl,
                  onChanged: (val) => onSearch(val),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 228, 228, 228),
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 146, 146, 146),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 131, 131, 131))),
                ),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .snapshots()
                  .asBroadcastStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> querySnapshot) {
                if (!querySnapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  List<dynamic> queryUserList = [];
                  queryUserList = querySnapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) {
                    return (element["username"]
                        .toString()
                        .toLowerCase()
                        .contains(searchControl.text.trim().toLowerCase()));
                  }).toList();
                  List<MyUser> users = [];
                  for (dynamic newUser in queryUserList) {
                    MyUser user =
                        MyUser.fromJson(newUser.data() as Map<String, dynamic>);
                    users.add(user);
                  }
                  return Container(
                      color: const Color.fromARGB(255, 245, 245, 245),
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (ctx, index) {
                          return FadeAnimation(
                              delay: 0.05 * index,
                              child: Slidable(
                                child: userPart(aUser: users[index]),
                                actionPane: const SlidableStrechActionPane(),
                                actionExtentRatio: 0.25,
                                actions: const [
                                  IconSlideAction(
                                    caption: "Archive",
                                    color: Color.fromARGB(255, 236, 236, 236),
                                    iconWidget: Icon(
                                      Icons.archive,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconSlideAction(
                                    caption: 'Share',
                                    color: Color.fromARGB(255, 236, 236, 236),
                                    iconWidget: Icon(
                                      Icons.share,
                                      color: Colors.black,
                                    ),
                                    onTap: null,
                                  ),
                                ],
                                secondaryActions: [
                                  IconSlideAction(
                                    caption: 'Remove',
                                    color: Colors.red,
                                    iconWidget: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    onTap: () => userRemoveWithIndex(index),
                                  ),
                                ],
                              ));
                        },
                      ),

                  );
                }
              },
            )));
  }

  userPart({required dynamic aUser}) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('UserFollowsUser').get(),
      builder:  (context,snapshot){
      if(!snapshot.hasData){
        return const Center(child: CircularProgressIndicator());
        List a;

      }
      else
      {

         isFollowing =Myfunction((snapshot.data! as dynamic).docs,(snapshot.data! as dynamic).docs.length,aUser.userID);

        //print((snapshot.data! as dynamic).docs[0]);
      }


      return InkWell(
        splashColor: const Color(0xEEC60744),
        onTap: () {
          (aUser.userID != FirebaseAuth.instance.currentUser!.uid)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ExploreUserProfile(userID: aUser.userID)))
              : Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PageNavigator()));
          //Navigator.push(context,MaterialPageRoute(builder: (context) => const UserProfile()));
        },
        child: Container(
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
                          backgroundImage:
                              CachedNetworkImageProvider(aUser.profilePicture),
                        ),
                      )),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(aUser.fullName,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 15, 15, 15),
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(aUser.username,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 90, 90, 90))),
                    ],
                  )
                ]),
                if (aUser.userID != FirebaseAuth.instance.currentUser!.uid)
                  GestureDetector(

                    onTap: () {
                      isFollowing ?
                      setState(() {
                        unFollow(aUser);
                      }):setState(() {
                        tryFollowing(aUser);
                      });
                    },
                    child: AnimatedContainer(
                      height: 35,
                      width: 110,
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                          color: isFollowing
                              ? Colors.blue[700]
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              color: isFollowing
                                  ? Colors.transparent
                                  : Colors.grey.shade700, // if statement
                              width: 1)),
                      child: Center(
                        child: Text(
                            isFollowing
                              ? "Unfollow"
                              : "Follow",
                          style: TextStyle(
                              color: isFollowing
                                  ? Colors.white
                                  : Colors.blue),
                        ),
                      ),
                    ),
                  )
              ],
            )),
      );
      }
    );
  }

  void tryFollowing(dynamic aUser) async {
    await UserService.followUser(
      FirebaseAuth.instance.currentUser!.uid,
      aUser.userID,
    );
    isFollowing = true;
    await updateFollowing();

  }
  void unFollow(dynamic aUser) async {
    await UserService.unFollow(
      FirebaseAuth.instance.currentUser!.uid,
      aUser.userID,
    );

    isFollowing = false;
    await updateFollowing();



  }

  bool Myfunction (var list, var length,var userID){
    for(int i = 0;i <length;i++ ){
      if(list[i]['follower'] ==FirebaseAuth.instance.currentUser!.uid &&list[i]['followedUser'] == userID ) {
        return true;
      }

    }
    return false;

  }
}



