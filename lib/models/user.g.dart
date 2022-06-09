// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      profilePicture: json['profilePicture'] as String? ??
          "https://firebasestorage.googleapis.com/v0/b/cs310-group-28.appspot.com/o/blank_pfp.png?alt=media&token=5d0aef19-82e7-4519-b545-7360e8b1a249",
      posts: json['posts'] as List<dynamic>? ?? const [],
      comments: json['comments'] as List<dynamic>? ?? const [],
      private: json['private'] as bool? ?? false,
      following: json['following'] as List<dynamic>? ?? const [],
      followers: json['followers'] as List<dynamic>? ?? const [],
      favorites: json['favorites'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'username': instance.username,
      'fullName': instance.fullName,
      'bio': instance.bio,
      'email': instance.email,
      'phone': instance.phone,
      'profilePicture': instance.profilePicture,
      'private': instance.private,
      'posts': instance.posts,
      'favorites': instance.favorites,
      'comments': instance.comments,
      'following': instance.following,
      'followers': instance.followers,
    };
