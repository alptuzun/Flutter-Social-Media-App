import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';

class UserService {

  static void addPost (MyUser user, Post p) {
    user.posts.add(p);
  }

  static void setPrivate(MyUser user, bool val) {
    user.private = val;
  }
}