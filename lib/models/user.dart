import 'package:cs310_group_28/models/post.dart';

class MyUser {
  String username;
  String fullName;
  String email;
  String? phone;
  List<Post> posts = [];
  List<Post> favorites = [];
  List<Post> comments = [];
  List<MyUser> following = [];
  List<MyUser> followers = [];
  String profilePicture;
  bool private;

  MyUser(
      {required this.username,
      required this.fullName,
      required this.email,
      this.phone,
      this.profilePicture = "assets/images/default_profile_picture.webp",
      this.private = false});

  int getNumPosts() {
    return posts.length;
  }

  int getNumFollowing() {
    return following.length;
  }

  int getNumFollowers() {
    return followers.length;
  }

  void addPost(Post p) {
    posts.add(p);
  }

  void setPrivate(bool val) {
    private = val;
  }
}
