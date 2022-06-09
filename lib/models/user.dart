import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class MyUser {
  String username;
  String fullName;
  String? bio;
  String email;
  String? phone;
  String profilePicture;
  bool private;
  List<dynamic> posts;
  List<dynamic> favorites;
  List<dynamic> comments;
  List<dynamic> following;
  List<dynamic> followers;

  MyUser({
    required this.username,
    required this.fullName,
    required this.email,
    this.bio,
    this.phone,
    this.profilePicture =
        "https://firebasestorage.googleapis.com/v0/b/cs310-group-28.appspot.com/o/blank_pfp.png?alt=media&token=5d0aef19-82e7-4519-b545-7360e8b1a249",
    this.posts = const [],
    this.comments = const [],
    this.private = false,
    this.following = const [],
    this.followers = const [],
    this.favorites = const [],
  });

  factory MyUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MyUser(
      username: data?['username'],
      fullName: data?['fullName'],
      email: data?['email'],
      bio: data?['bio'],
      phone: data?['phone'],
      profilePicture: data?["profilePicture"],
      private: data?['private'],
      comments:
          data?['comments'] is Iterable ? List.from(data?['comments']) : [],
      posts: data?['posts'] is Iterable ? List.from(data?['posts']) : [],
      following:
      data?['following'] is Iterable ? List.from(data?['following']) : [],
      followers: data?['followers'] is Iterable ? List.from(data?['followers']) : [],
      favorites: data?['favorites'] is Iterable ? List.from(data?['favorites']) : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "username": username,
      "fullName": fullName,
      "email": email,
      "bio": bio,
      "phone": phone,
      "profilePicture": profilePicture,
      "private" : private,
      "comments" : comments,
      "posts" : posts,
      "following" : following,
      "followers" : followers,
      "favorites" : favorites,
    };
  }

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}