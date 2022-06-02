
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/user_search_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:cs310_group_28/services/fadeanimation.dart';

import '../visuals/colors.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const String routeName = "/explore_SearchScreen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<MyUsers> _foundUsers = [];

  void initState() {
    super.initState();
    _foundUsers = listOfUsers;
  }

  onSearch (String search){
    setState( (){
      _foundUsers = listOfUsers.where((element) => element.name.toLowerCase().contains(search)).toList();
    });

  }

  UserRemoveWithIndex (int which_user){
    setState((){
      _foundUsers.removeAt(which_user);
    });
  }
  UserRemoveWithName (String name){
    setState((){
      _foundUsers.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:GestureDetector(
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
            body: Container(
                color: Color.fromARGB(255, 245, 245, 245),
                child: _foundUsers.isEmpty ? Center(child:  Text("No user has been found",style: TextStyle(color: Colors.red),),)
                    :ListView.builder(
                  itemCount: _foundUsers.length,
                  itemBuilder: (ctx,index){
                    return FadeAnimation(
                        delay: 0.7*index,
                        child: Slidable(
                          child: userPart(aUser: _foundUsers[index] ),
                          actionPane:const SlidableStrechActionPane(),
                          actionExtentRatio: 0.25,
                          actions:  [
                            const IconSlideAction(
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
                              iconWidget:const Icon(
                                Icons.share,
                                color: Colors.black,
                              ),
                              onTap: () => print("Share"),
                            ),

                          ],
                          secondaryActions: [
                            IconSlideAction(
                              caption: 'Remove',
                              color: Colors.red,
                              iconWidget:const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onTap: () => UserRemoveWithIndex(index),
                            ),
                          ],




                        )
                    );
                  },
                )


            ),


            ),

          ),

    );
  }
  userPart({required MyUsers aUser})  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [

            SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    aUser.imageAd,
                    fit: BoxFit.cover,
                  ),
                )
            ),
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
                      style: TextStyle(color: Color.fromARGB(255, 90, 90, 90))),

              ],
            )


          ]
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                aUser.isFollowed = !aUser.isFollowed;
              });
            },
            child: AnimatedContainer(
              height: 35,
              width: 110,
              duration: Duration(milliseconds: 250),
              decoration:  BoxDecoration(
                  color:
                  aUser.isFollowed ? Colors.blue[700] : Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                      color: aUser.isFollowed ? Colors.transparent : Colors.grey.shade700, // if statement
                      width: 1
                  )
              ),
              child: Center(
                child: Text(
                  aUser.isFollowed ? "Unfollow" : "Follow",
                  style: TextStyle(
                    color: aUser.isFollowed ? Colors.white: Colors.blue
                  ),
                ),

              ),
            ),




          )
        ],
      )

    );
  }
}

