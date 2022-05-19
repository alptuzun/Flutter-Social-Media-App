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
    return Card(
          color: Colors.white38,
          margin: const EdgeInsets.all(100),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth(context, dividedBy: 100),
                    ),
                    const Spacer(),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                  child: Image(
                    image: AssetImage(post.imageName.toString()),
                    alignment: Alignment.center,
                    isAntiAlias: true,
                    fit: BoxFit.contain,
                    width: 200,
                    height: 200,
                    filterQuality: FilterQuality.high,
                  ),
                ),

                  ],
                )
            ),
        );
  }

  }
