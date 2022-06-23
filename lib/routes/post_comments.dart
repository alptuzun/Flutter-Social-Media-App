import 'package:cs310_group_28/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/comment.dart';
import '../services/post_service.dart';

class SingleCommentView extends StatefulWidget {
  final Comment comment;
  const SingleCommentView({Key? key, required this.comment}) : super(key: key);

  @override
  State<SingleCommentView> createState() => _SingleCommentViewState();
}

class _SingleCommentViewState extends State<SingleCommentView> {
  String userPfp =
      "https://firebasestorage.googleapis.com/v0/b/cs310-group-28.appspot.com/o/blank_pfp.png?alt=media&token=5d0aef19-82e7-4519-b545-7360e8b1a249";
  String username = "";

  @override
  void initState() {
    UserService.getUser(widget.comment.userID).then((user) {
      setState(() {
        username = user.username;
        userPfp = user.profilePicture;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userPfp),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(widget.comment.comment)
          ],
        ),
      ),
    );
  }
}

class PostCommentsView extends StatefulWidget {
  final List<Comment> comments;
  final String userID;
  final String postID;
  const PostCommentsView(
      {Key? key,
      required this.comments,
      required this.userID,
      required this.postID})
      : super(key: key);

  @override
  State<PostCommentsView> createState() => _PostCommentsViewState();
}

class _PostCommentsViewState extends State<PostCommentsView> {
  String? _currentComment;
  final _commentField = TextEditingController();

  void handlePostSend() async {
    if (_currentComment != null) {
      Comment newComment = Comment(
          postID: widget.postID,
          time: DateTime.now(),
          userID: widget.userID,
          comment: _currentComment!);
      setState(() {
        widget.comments.add(newComment);
        widget.comments.sort((c1, c2) => c2.time.compareTo(c1.time));
      });

      await PostService.commentToPost(newComment, widget.userID);
      _currentComment = null;
      _commentField.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: TextField(
                        controller: _commentField,
                        minLines: 1,
                        maxLines: 4,
                        onChanged: (value) {
                          setState(() {
                            _currentComment = value;
                          });
                        },
                        onSubmitted: (_) {
                          handlePostSend();
                        },
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "Add your comment",
                            hintStyle: GoogleFonts.poppins(fontSize: 14),
                            border: InputBorder.none),
                        autocorrect: false,
                        textInputAction: TextInputAction.send,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: handlePostSend, child: const Text("Post")),
                ],
              ),
              ...widget.comments
                  .map((c) => SingleCommentView(comment: c))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
