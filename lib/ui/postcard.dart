import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cs310_group_28/models/comment.dart';
import 'package:cs310_group_28/routes/post_comments.dart';
import 'package:cs310_group_28/services/edit_post.dart';
import 'package:cs310_group_28/services/post_service.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:cs310_group_28/visuals/screen_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/visuals/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatefulWidget {
  late Post realPost;
  final VoidCallback likes;
  final VoidCallback dislikes;
  final dynamic jsonPost;
  final bool isOwner;
  final String userID;

  PostCard(
      {Key? key,
      required this.realPost,
      required this.likes,
      required this.dislikes,
      required this.isOwner,
      required this.userID,
      this.jsonPost})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String? comment;
  int numLikes = 0;
  late StreamSubscription postStream;
  List<Comment> comments = [];

  @override
  void initState() {
    postStream = widget.realPost.postStream().listen((event) {
      if (event.runtimeType == int) {
        setState(() {
          numLikes = event;
        });
      } else if (event.runtimeType == List<Comment>) {
        setState(() {
          comments = event;
          comments.sort((a, b) => a.time.compareTo(b.time));
        });
      } else {
        setState(() {
          widget.realPost = event;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    postStream.cancel();
    super.dispose();
  }

  Future<Map<String, dynamic>> getData() async {
    final user = await UserService.getUser(widget.realPost.userID);
    final pFp = await UserService.getProfilePicture(widget.realPost.userID);
    return {"user": user, "pFp": pFp};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              CachedNetworkImageProvider(snapshot.data["pFp"])),
                      SizedBox(
                        width: screenWidth(context, dividedBy: 100) * 2,
                      ),
                      Text(
                        snapshot.data["user"].fullName,
                        style: Styles.userNameTextStyle,
                        textAlign: TextAlign.start,
                        textScaleFactor: 0.75,
                      ),
                      SizedBox(
                        width: screenWidth(context, dividedBy: 100),
                      ),
                      Text(
                        "@${snapshot.data["user"].username}",
                        style: GoogleFonts.poppins(
                          color: Colors.black45,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const Spacer(),
                      Text(
                        "${widget.realPost.postTime.day}-${widget.realPost.postTime.month}-${widget.realPost.postTime.year}",
                        style: GoogleFonts.poppins(
                          color: Colors.black45,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  if (widget.realPost.mediaURL != null)
                    Container(
                        padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                        child: CachedNetworkImage(
                          imageUrl: widget.realPost.mediaURL!,
                          alignment: Alignment.center,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                        )),
                  Text(
                    widget.realPost.caption,
                    style: Styles.appMainTextStyle,
                  ),
                  if (widget.realPost.caption.isNotEmpty)
                    SizedBox(
                      height: screenHeight(context, dividedBy: 100),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.isOwner == true)
                        PopupMenuButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.black,
                          ),
                          iconSize: 35,
                          onSelected: (value) {
                            if (value == 'Edit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditPost(editedPost: widget.realPost)),
                              );
                            } else {
                              setState(() {
                                PostService.deletePost(
                                    widget.userID, widget.realPost);
                              });
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                height: screenHeight(context) / 100 * 4,
                                value: 'Edit',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("Edit"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                height: screenHeight(context) / 100 * 4,
                                value: 'Delete',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("Delete"),
                                  ],
                                ),
                              ),
                            ];
                          },
                        ),
                      const Spacer(flex: 30),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_upward_rounded),
                        onPressed: widget.likes,
                        iconSize: screenWidth(context, dividedBy: 20),
                        splashRadius: 18,
                        color: Colors.green,
                      ),
                      const Spacer(
                        flex: 8,
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_downward_rounded),
                        onPressed: widget.dislikes,
                        iconSize: screenWidth(context, dividedBy: 20),
                        splashRadius: 18,
                        color: Colors.red,
                      ),
                      const Spacer(
                        flex: 6,
                      ),
                      Text(numLikes.toString(), style: Styles.appMainTextStyle),
                      const Spacer(
                        flex: 21,
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.mode_comment_outlined),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostCommentsView(
                                      comments: comments,
                                      userID: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      postID: widget.realPost.postID!,
                                    ))),
                        iconSize: screenWidth(context, dividedBy: 20),
                        splashRadius: 18,
                        color: Colors.blue,
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      Text(comments.length.toString(),
                          style: Styles.appMainTextStyle),
                      const Spacer(flex: 20),
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: SizedBox(
                width: screenWidth(context),
                height: screenHeight(context, dividedBy: 5),
                child: const Center(child: CircularProgressIndicator())),
          );
        }
      },
    );
  }
}
