
import 'package:flutter/material.dart';

import '../models/post.dart';

class exploreTiles extends StatelessWidget {
  const exploreTiles ({ Key? key, required this.post}) : super (key:key);
  final Post post;

  @override
  Widget build (BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //color: Colors.purpleAccent,
        child: Stack(
          children: [Image(image: AssetImage(post.imageName))
          ]
        )
      ),
    );
  }
}