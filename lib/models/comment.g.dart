// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      comment: json['comment'] as String,
      userID: json['userID'] as String,
      postID: json['postID'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'comment': instance.comment,
      'userID': instance.userID,
      'postID': instance.postID,
      'time': instance.time.toIso8601String(),
    };
