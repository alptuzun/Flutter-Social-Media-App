import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';

class ExploreTiles extends StatelessWidget {
  const ExploreTiles ({ Key? key, required this.post}) : super (key:key);
  final Post post;

  @override
  Widget build (BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: Container(
        color: Colors.pink,
        //https://media.istockphoto.com/photos/big-and-small-picture-id172759822?b=1&k=20&m=172759822&s=170667a&w=0&h=kkmaR2OYuS14rTiEotbzXoBecwnRePNC79Jsgl3M4dY=
        //'https://media.istockphoto.com/photos/tight-concept-picture-id474578119?b=1&k=20&m=474578119&s=170667a&w=0&h=lQPidEuEnphiXRLhQku8p3gylssLCqQFRgEhm9k7JFY='
        //color: Colors.purpleAccent,
        child: Stack(
          children: [Image.network(post.postURL,fit: BoxFit.fill,)


          ]
        )
      ),
    );
  }
}