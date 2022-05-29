import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/models/comment.dart';
import 'package:image_picker/image_picker.dart';

class Post {
  MyUser user;
  String? caption;
  String date;
  List<MyUser> likes = [];
  List<Comment> comments = [];
  String? location;
  String imageName;
  String? price;
  XFile? image;

  Post(
      {required this.user,
      this.caption,
      required this.date,
      this.location,
      required this.imageName,
      this.price, this.image});

  int getNumLikes() {
    return likes.length;
  }

  int getNumComments() {
    return comments.length;
  }

}
