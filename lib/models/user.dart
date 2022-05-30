import 'package:cs310_group_28/models/post.dart';
/*
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@Freezed()
class MyUser with _$MyUser {
  factory MyUser._();
  const factory MyUser({
    required String username,
    required String fullName,
    required String email,
    String? phone,
    @Default("assets/images/default_profile_picture.webp") String profilePicture,
    @Default(true)bool private,
    @Default([]) List<dynamic> posts,
    @Default([]) List<dynamic> favorites,
    @Default([]) List<dynamic> comments,
    @Default([]) List<dynamic> following,
    @Default([]) List<dynamic> followers,
  }) = _MyUser;


  void addPost(dynamic p) {
    posts.add(p);
  }

  void setPrivate(bool val) {
    private = val;
  }

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

}*/

class MyUser {
  String username;
  String fullName;
  String email;
  String? phone;
  List<dynamic> posts = [];
  List<dynamic> favorites = [];
  List<dynamic> comments = [];
  List<dynamic> following = [];
  List<dynamic> followers = [];
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