// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      postID: json['postID'] as String,
      userID: json['userID'] as String,
      postTime: DateTime.parse(json['postTime'] as String),
      user: MyUser.fromJson(json['user'] as Map<String, dynamic>),
      caption: json['caption'] as String?,
      location: json['location'] as String?,
      imageName: json['imageName'] as String,
      likes: json['likes'] as List<dynamic>? ?? const [],
      comments: json['comments'] as List<dynamic>? ?? const [],
      price: json['price'] as String?,
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'postID': instance.postID,
      'userID': instance.userID,
      'postTime': instance.postTime.toIso8601String(),
      'user': instance.user,
      'caption': instance.caption,
      'location': instance.location,
      'imageName': instance.imageName,
      'likes': instance.likes,
      'comments': instance.comments,
      'price': instance.price,
    };
