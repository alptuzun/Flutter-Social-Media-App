// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyNotification _$$_MyNotificationFromJson(Map<String, dynamic> json) =>
    _$_MyNotification(
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
      isSeen: json['isSeen'] as bool? ?? false,
    );

Map<String, dynamic> _$$_MyNotificationToJson(_$_MyNotification instance) =>
    <String, dynamic>{
      'text': instance.text,
      'date': instance.date.toIso8601String(),
      'isSeen': instance.isSeen,
    };
