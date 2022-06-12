// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postURL: json['postURL'] as String,
      postID: json['postID'] as String,
      userID: json['userID'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      postTime: DateTime.parse(json['postTime'] as String),
      type: json['type'] as String,
      dislikes: json['dislikes'] as List<dynamic>? ?? const [],
      comments: json['comments'] as List<dynamic>? ?? const [],
      caption: json['caption'] as String? ?? "",
      likes: json['likes'] as List<dynamic>? ?? const [],
      imageName: json['imageName'] as String? ?? "",
      location: json['location'] as String? ?? "",
      price: json['price'] as String? ?? "-1",
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postURL': instance.postURL,
      'postID': instance.postID,
      'userID': instance.userID,
      'username': instance.username,
      'fullName': instance.fullName,
      'postTime': instance.postTime.toIso8601String(),
      'caption': instance.caption,
      'location': instance.location,
      'imageName': instance.imageName,
      'likes': instance.likes,
      'comments': instance.comments,
      'dislikes': instance.dislikes,
      'price': instance.price,
      'type': instance.type,
    };
