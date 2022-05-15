import 'package:cs310_group_28/models/user.dart';

class Post {
  User user;
  String? caption;
  String date;
  int likes;
  int comments;
  String? location;
  String imageName;

  Post(
      {required this.user,
      this.caption,
      required this.date,
      required this.likes,
      required this.comments,
      this.location,
      required this.imageName});
}
