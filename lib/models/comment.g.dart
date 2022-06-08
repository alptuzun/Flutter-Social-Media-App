// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      user: MyUser.fromJson(json['user'] as Map<String, dynamic>),
      time: DateTime.parse(json['time'] as String),
      content: json['content'] as String,
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'user': instance.user,
      'time': instance.time.toIso8601String(),
      'content': instance.content,
    };
