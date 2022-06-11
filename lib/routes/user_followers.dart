import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/user_search_model.dart';
import '../visuals/fade_animation.dart';
import '../visuals/text_style.dart';

class user_followers extends StatefulWidget {
  const user_followers({Key? key}) : super(key: key);

  @override
  State<user_followers> createState() => _user_followersState();
}

class _user_followersState extends State<user_followers> {

  userRemoveWithIndex(int whichUser) {
    setState(() {
      listOfUsers.removeAt(whichUser);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          "Followers",
          style: Styles.appBarTitleTextStyle,
        ),
      ),
      body: Container(
          color: const Color.fromARGB(255, 245, 245, 245),
          child: listOfUsers.isEmpty
              ? const Center(
            child: Text(
              "No user has been found",
              style: TextStyle(color: Colors.red),
            ),
          )
              : ListView.builder(
            itemCount: listOfUsers.length,
            itemBuilder: (ctx, index) {
              return FadeAnimation(
                  delay: 0.05 * index,
                  child: Slidable(
                    child: userPart(aUser: listOfUsers[index]),
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
          )),
    );
  }
  userPart({required MyUsers aUser}) {
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
                    child: Image.asset(
                      aUser.imageAd,
                      fit: BoxFit.cover,
                    ),
                  )),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(aUser.name,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 15, 15, 15),
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(aUser.userName,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 90, 90, 90))),
                ],
              )
            ]),
            GestureDetector(
              onTap: () {
                setState(() {
                  aUser.isFollowed = !aUser.isFollowed;
                });
              },
              child: AnimatedContainer(
                height: 35,
                width: 110,
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                    color: aUser.isFollowed
                        ? Colors.blue[700]
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        color: aUser.isFollowed
                            ? Colors.transparent
                            : Colors.grey.shade700, // if statement
                        width: 1)),
                child: Center(
                  child: Text(
                    aUser.isFollowed ? "Unfollow" : "Follow",
                    style: TextStyle(
                        color: aUser.isFollowed ? Colors.white : Colors.blue),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}




