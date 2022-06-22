// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      mediaURL: json['postURL'] as String?,
      postID: json['postID'] as String,
      userID: json['userID'] as String,
      postTime: DateTime.parse(json['postTime'] as String),
      caption: json['caption'] as String? ?? "",
      location: json['location'] as String? ?? "",
      tags: json["tags"] as List<String>? ?? <String>[],
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postURL': instance.mediaURL,
      'postID': instance.postID,
      'userID': instance.userID,
      'postTime': instance.postTime.toIso8601String(),
      'caption': instance.caption,
      'location': instance.location,
      "tags": instance.tags,
      "mediaURL": instance.mediaURL
    };
