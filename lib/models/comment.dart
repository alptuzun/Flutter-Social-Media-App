import 'package:cs310_group_28/models/user.dart';
/*
import 'package:freezed_annotation/freezed_annotation.dart';
part 'comment.g.dart';
part 'comment.freezed.dart';

@Freezed()
class Comment with _Comment {
  const factory Comment({
    required String content,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJason(json);
}
*/

class Comment {
  MyUser user;
  String content;
  Comment({required this.user, required this.content});
}
