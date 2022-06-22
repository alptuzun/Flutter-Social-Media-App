import 'package:cs310_group_28/routes/explore_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';

class ExploreTiles extends StatelessWidget {
  const ExploreTiles({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  ExploreUserProfile(userID: post.userID)));
        },
        child: Container(
            color: Colors.pink,
            child: Image.network(
              post.mediaURL!,
              fit: BoxFit.cover
            )),
      ),
    );
  }
}
