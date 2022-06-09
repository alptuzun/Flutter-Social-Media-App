// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      fullName: json['fullName'] as String,
      message: json['message'] as String,
      username: json['username'] as String,
      time: DateTime.parse(json['time'] as String),
      messageType: json['messageType'] as String,
      incoming: json['incoming'] as bool,
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'message': instance.message,
      'time': instance.time.toIso8601String(),
      'username': instance.username,
      'fullName': instance.fullName,
      'messageType': instance.messageType,
      'isRead': instance.isRead,
      'incoming': instance.incoming,
    };
