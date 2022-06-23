// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      message: json['message'] as String,
      userID: json['userID'] as String,
      time: DateTime.parse(json['time'] as String),
      messageType: json['messageType'] as String,
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'message': instance.message,
      'time': instance.time.toIso8601String(),
      'userID': instance.userID,
      'messageType': instance.messageType,
      'isRead': instance.isRead,
    };
