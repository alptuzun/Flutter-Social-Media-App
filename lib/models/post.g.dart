// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      user: json['user'],
      caption: json['caption'] as String?,
      date: json['date'] as String,
      location: json['location'] as String?,
      imageName: json['imageName'] as String,
      likes: json['likes'] as List<dynamic>? ?? const [],
      comments: json['comments'] as List<dynamic>? ?? const [],
      price: json['price'] as String?,
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'user': instance.user,
      'caption': instance.caption,
      'date': instance.date,
      'location': instance.location,
      'imageName': instance.imageName,
      'likes': instance.likes,
      'comments': instance.comments,
      'price': instance.price,
    };
