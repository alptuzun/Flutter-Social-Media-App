// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      time: DateTime.parse(json['time'] as String),
      userID: json['userID'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'userID': instance.userID,
      'content': instance.content,
      'time': instance.time.toIso8601String(),
    };
