import 'package:cached_network_image/cached_network_image.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback comment;
  final VoidCallback likes;
  final VoidCallback dislikes;
  final bool isOwner;
  final String userID;

  const PostCard(
      {Key? key,
      required this.post,
      required this.comment,
      required this.likes,
      required this.dislikes,
      required this.isOwner,
      required this.userID})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String userPfp = "";

  Future getAvatar() async {
    final pFp = await UserService.getProfilePicture(widget.post.userID);
    setState(() {
      userPfp = pFp;
    });
  }

  @override
  void initState() {
    super.initState();
    getAvatar();
  }

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
                if(userPfp.isNotEmpty)
                CircleAvatar(
                  radius: 15,
                  backgroundImage: CachedNetworkImageProvider(userPfp),
                ),
                SizedBox(
                  width: screenWidth(context, dividedBy: 100) * 2,
                ),
                Text(
                  widget.post.fullName,
                  style: Styles.userNameTextStyle,
                  textAlign: TextAlign.start,
                  textScaleFactor: 0.75,
                ),
                SizedBox(
                  width: screenWidth(context, dividedBy: 100),
                ),
                Text(
                  "@${widget.post.username}",
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.start,
                ),
                const Spacer(),
                Text(
                  "${widget.post.postTime.day}-${widget.post.postTime.month}-${widget.post.postTime.year}",
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            if (widget.post.type != "text")
              Container(
                  padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                  child: CachedNetworkImage(
                    imageUrl: widget.post.postURL,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                  )),
            Text(
              widget.post.caption,
              style: Styles.appMainTextStyle,
            ),
            if (widget.post.caption.isNotEmpty)
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
                  onPressed: widget.likes,
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
                  onPressed: widget.dislikes,
                  iconSize: screenWidth(context, dividedBy: 20),
                  splashRadius: 14,
                  color: Colors.red,
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(widget.post.likes.length.toString(),
                    style: Styles.appMainTextStyle),
                const Spacer(
                  flex: 7,
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.mode_comment_outlined),
                  onPressed: widget.comment,
                  iconSize: screenWidth(context, dividedBy: 20),
                  splashRadius: 14,
                  color: Colors.blue,
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(widget.post.comments.length.toString(),
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
