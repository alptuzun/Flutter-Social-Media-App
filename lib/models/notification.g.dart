// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyNotification _$MyNotificationFromJson(Map<String, dynamic> json) =>
    MyNotification(
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
      isSeen: json['isSeen'] as bool? ?? false,
    );

Map<String, dynamic> _$MyNotificationToJson(MyNotification instance) =>
    <String, dynamic>{
      'text': instance.text,
      'date': instance.date.toIso8601String(),
      'isSeen': instance.isSeen,
    };
