import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatelessWidget {
  final Post post;

  final VoidCallback comment;
  final VoidCallback likes;

  const PostCard({Key? key, required this.post, required this.comment, required this.likes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  post.user.fullName,
                  style: Styles.userNameTextStyle,
                  textAlign: TextAlign.start,
                  textScaleFactor: 0.75,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "@" + post.user.username,
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.start,

                ),
                const Spacer(),
                Text(
                  post.date,
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
              child: Image(
                image: AssetImage(post.imageName.toString()),
                alignment: Alignment.center,
                isAntiAlias: true,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
            if (post.caption != null)
              Text(
                post.caption ?? "",
                style: Styles.appMainTextStyle,
              ),
            if (post.caption != null)
              const SizedBox(
                height: 10,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.thumb_up),
                  onPressed: likes,
                  iconSize: 14.0,
                  splashRadius: 14,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(post.likes.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    )),
                const SizedBox(width: 100),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.comment),
                  onPressed: comment,
                  iconSize: 14.0,
                  splashRadius: 14,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(post.comments.toString(),
                    style: Styles.appMainTextStyle
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
