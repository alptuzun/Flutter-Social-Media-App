// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
    username: json['username'] as String,
    fullName: json['fullName'] as String,
    email: json['email'] as String,
    userID: json['userID'] as String,
    bio: json['bio'] as String? ?? "",
    phone: json['phone'] as String? ?? "",
    profilePicture: json['profilePicture'] as String? ??
        "https://firebasestorage.googleapis.com/v0/b/cs310-group-28.appspot.com/o/blank_pfp.png?alt=media&token=5d0aef19-82e7-4519-b545-7360e8b1a249",
    notifications: json['notifications'] as List<dynamic>? ?? const [],
    private: json['private'] as bool? ?? false,
    interests: json['interests'].cast<String>());

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'username': instance.username,
      'fullName': instance.fullName,
      'bio': instance.bio,
      'email': instance.email,
      'phone': instance.phone,
      'profilePicture': instance.profilePicture,
      'private': instance.private,
      'userID': instance.userID,
      'notifications': instance.notifications,
      "interests": instance.interests
    };
