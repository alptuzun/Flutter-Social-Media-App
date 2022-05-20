import 'dart:math';

import 'package:cs310_group_28/models/user.dart';

import 'package:cs310_group_28/models/comment.dart';

class Post {
  User user;
  String? caption;
  String date;
  List<User> likes = [];
  List<Comment> comments = [];
  String? location;
  String imageName;

  Post(
      {required this.user,
      this.caption,
      required this.date,
      this.location,
      required this.imageName});

  int getNumLikes() {
    return likes.length;
  }

  int getNumComments() {
    return comments.length;
  }
}
