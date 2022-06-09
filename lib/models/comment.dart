import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  String userID;
  String content;
  DateTime time;

  Comment({
    required this.time,
    required this.userID,
    required this.content,
  });

  factory Comment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Comment(
      userID: data?["userID"],
      content: data?['content'],
      time: data?['time'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "userID": userID,
      "content": content,
      "time": time,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

}
