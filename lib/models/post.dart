import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  String postURL;
  String postID;
  String userID;
  String username;
  String fullName;
  DateTime postTime;
  String caption;
  String location;
  String imageName;
  List<dynamic> likes;
  List<dynamic> comments;
  List<dynamic> dislikes;
  String price;
  String type;

  Post({
    required this.postURL,
    required this.postID,
    required this.userID,
    required this.username,
    required this.fullName,
    required this.postTime,
    required this.type,
    this.dislikes = const [],
    this.comments = const [],
    this.caption = "",
    this.likes = const [],
    this.imageName = "",
    this.location = "",
    this.price = "-1",
  });

  factory Post.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Post(
      type: data?['type'],
      userID: data?['userID'],
      username: data?['username'],
      fullName: data?['fullName'],
      caption: data?['caption'],
      postTime: DateTime.parse(data?['postTime'] as String),
      postID: data?['postID'],
      postURL: data?["postURL"],
      price: data?['price'],
      location: data?['location'],
      imageName: data?['imageName'],
      comments:
          data?['comments'] is Iterable ? List.from(data?['comments']) : [],
      likes: data?["likes"] is Iterable ? List.from(data?["likes"]) : [],
      dislikes: data?["dislikes"] is Iterable ? List.from(data?["dislikes"]) : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "username": username,
      "fullName": fullName,
      "type": type,
      "caption": caption,
      "location": location,
      "price": price,
      "postURL": postURL,
      "comments": comments,
      "likes": likes,
      "postID": postID,
      "imageName": imageName,
      "postTime": postTime.toIso8601String(),
      "userID": userID,
      "dislikes": dislikes,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
