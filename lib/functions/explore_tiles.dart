import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';

class ExploreTiles extends StatelessWidget {
  const ExploreTiles({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: Container(
          color: Colors.pink,
          //color: Colors.purpleAccent,
          child: Image.network(
            post.mediaURL!,
            fit: BoxFit.cover
          )),
    );
  }
}
