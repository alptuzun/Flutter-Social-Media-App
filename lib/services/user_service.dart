import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';

class UserService {
  static void addPost(User user, Post p) {
    user.posts.add(p);
  }

  static void setPrivate(User user, bool val) {
    user.private = val;
  }
}
