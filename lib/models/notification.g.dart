// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyNotification _$MyNotificationFromJson(Map<String, dynamic> json) =>
    MyNotification(
      userID: json['userID'] as String,
      type: json['type'] as String,
      date: DateTime.parse(json['date'] as String),
      isSeen: json['isSeen'] as bool? ?? false,
    );

Map<String, dynamic> _$MyNotificationToJson(MyNotification instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'type': instance.type,
      'date': instance.date.toIso8601String(),
      'isSeen': instance.isSeen,
    };
