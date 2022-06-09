import 'package:cached_network_image/cached_network_image.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback comment;
  final VoidCallback likes;
  final VoidCallback dislikes;

  const PostCard(
      {Key? key,
      required this.post,
      required this.comment,
      required this.likes,
      required this.dislikes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  post.fullName,
                  style: Styles.userNameTextStyle,
                  textAlign: TextAlign.start,
                  textScaleFactor: 0.75,
                ),
                SizedBox(
                  width: screenWidth(context, dividedBy: 100),
                ),
                Text(
                  "@${post.username}",
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.start,
                ),
                const Spacer(),
                Text(
                  "${post.postTime.day}-${post.postTime.month}-${post.postTime.year}",
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            if (post.type != "text")
              Container(
                  padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                  child: post.imageName.isNotEmpty
                      ? Image(
                          image: AssetImage(post.imageName.toString()),
                          alignment: Alignment.center,
                          isAntiAlias: true,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        )
                      : CachedNetworkImage(
                          imageUrl: post.postURL,
                          alignment: Alignment.center,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                        )),
            Text(
              post.caption,
              style: Styles.appMainTextStyle,
            ),
            if (post.caption.isNotEmpty)
              SizedBox(
                height: screenHeight(context, dividedBy: 100),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 20),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_upward_rounded),
                  onPressed: likes,
                  iconSize: screenWidth(context, dividedBy: 20),
                  splashRadius: 14,
                  color: Colors.green,
                ),
                const Spacer(
                  flex: 2,
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_downward_rounded),
                  onPressed: dislikes,
                  iconSize: screenWidth(context, dividedBy: 20),
                  splashRadius: 14,
                  color: Colors.red,
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(post.likes.length.toString(),
                    style: Styles.appMainTextStyle),
                const Spacer(
                  flex: 7,
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.mode_comment_outlined),
                  onPressed: comment,
                  iconSize: screenWidth(context, dividedBy: 20),
                  splashRadius: 14,
                  color: Colors.blue,
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(post.comments.length.toString(),
                    style: Styles.appMainTextStyle),
                const Spacer(flex: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}
