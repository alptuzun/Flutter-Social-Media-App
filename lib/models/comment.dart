import 'package:cs310_group_28/models/user.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'comment.g.dart';
part 'comment.freezed.dart';

@Freezed()
class Comment with _$Comment {
  factory Comment({
    required MyUser user,
    required DateTime time,
    required String content,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
