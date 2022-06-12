import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/user.dart';
import '../models/user_search_model.dart';
import '../services/user_service.dart';
import '../visuals/colors.dart';
import '../visuals/fade_animation.dart';
import '../visuals/text_style.dart';
import 'explore_user_profile.dart';

class SearchListCard extends StatefulWidget {
  const SearchListCard({Key? key}) : super(key: key);

  @override
  State<SearchListCard> createState() => _SearchListCardState();
}

class _SearchListCardState extends State<SearchListCard> {
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
  void initState()  {
    super.initState();
    prt();
    getUsersFollowers();
    print(followings);
    //handleFollowUser();
  }
  isfollows(dynamic user_id) async {

    var result = await UserService.isfollowing( uid: FirebaseAuth.instance.currentUser!.uid, followinguserid: user_id);
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
    print('Followings are:');
    print(followings[1]=='X9nyMA5q6XePW6JH3320xLVZq6F3' ); //== " X9nyMA5q6XePW6JH3320xLVZq6F3X9nyMA5q6XePW6JH3320xLVZq6F3"
  }
  Future updateFollowing() async{
    List list = await UserService.getFollowings(FirebaseAuth.instance.currentUser!.uid);
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
      _foundUsers =
          list_of_users.where((element) => element.fullName.toLowerCase().contains(search))
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
          title:  Center(child: Text('Followings',style: Styles.appBarTitleTextStyle,) ),
        ),
        body: FutureBuilder(
          future: UserService.getFollowings(FirebaseAuth.instance.currentUser!.uid),

          builder: (context,snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }
            return Container(

              color: const Color.fromARGB(255, 245, 245, 245),

              child: ListView.builder(
                itemCount: (snapshot.data! as dynamic).length ,
                itemBuilder: (ctx, index) {

                  return
                    userPart(aUser: (snapshot.data! as dynamic)[index],index: 0);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  userPart({required dynamic aUser, required int index}) {
    return  InkWell(
      splashColor: const Color(0xEEC60744),
      onTap: (){
        Navigator.push(context,MaterialPageRoute(
            builder: (context) =>  ExploreUserProfile(userID: aUser)));
      },
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Users').where('userID',isEqualTo: aUser ).get(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
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
                            backgroundImage:
                            CachedNetworkImageProvider((snapshot.data! as dynamic).docs[index]['profilePicture'] ),
                          ),
                        )),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((snapshot.data! as dynamic).docs[index]['username'] ,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 15, 15, 15),
                                fontWeight: FontWeight.w700)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text((snapshot.data! as dynamic).docs[index]['username'] ,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 90, 90, 90))),
                      ],
                    )
                  ]),
                  
                ],
              ));
        }

      ),
    );
  }

  void user_try_following(dynamic aUser) async {
    await UserService.followUser(FirebaseAuth.instance.currentUser!.uid,aUser['userID'],);
    await updateFollowing();
  }

  Future<String> givePicture(dynamic id) async {
    return await UserService.getProfilePicture(id);
  }
}
