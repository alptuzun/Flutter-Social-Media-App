import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';


class SearchCard extends StatelessWidget {
  final Post post;

  const SearchCard({Key? key, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: (){null;},
          splashColor: const Color(0xFFA1A1A1),
          child: Card(
                color: Colors.white38,
                margin: const EdgeInsets.fromLTRB(20,5,10,5),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [

                      Container(

                        padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                        child: Image(
                          image: AssetImage(post.imageName.toString()),
                          alignment: Alignment.center,
                          isAntiAlias: true,
                          fit: BoxFit.contain,
                          height: 100,
                          width: 150,


                          filterQuality: FilterQuality.high,
                        ),
                      ),

                        ],
                      )
                  ),
              ),
        ),

        InkWell(
          onTap: (){null;},
          splashColor: const Color(0xFFA1A1A1),
          child: Card(
            color: Colors.white38,
            margin: const EdgeInsets.all(10),
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [

                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                      child: Image(
                        image: AssetImage(post.imageName.toString()),
                        alignment: Alignment.center,
                        isAntiAlias: true,
                        fit: BoxFit.contain,
                        height: 100,
                        width: 150,



                        filterQuality: FilterQuality.high,
                      ),

                    ),

                  ],
                )
            ),
          ),
        ),


      ],
    );

  }

  }
