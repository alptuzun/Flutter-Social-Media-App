import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  String? commentID;
  String userID;
  String postID;
  String comment;
  DateTime time;

  Comment(
      {required this.userID,
      required this.postID,
      required this.comment,
      required this.time,
      this.commentID});

  factory Comment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Comment(
        userID: data?["userID"],
        postID: data?["postID"],
        time: DateTime.parse(data?['time'] as String),
        comment: data?["comment"],
        commentID: snapshot.reference.id);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "userID": userID,
      "postID": postID,
      "comment": comment,
      "time": time.toIso8601String(),
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Future<MyUser> get user async {
    return await UserService.getUser(userID);
  }
}
