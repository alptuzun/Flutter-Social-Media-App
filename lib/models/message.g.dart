// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      message: json['message'] as String,
      time: DateTime.parse(json['time'] as String),
      user: MyUser.fromJson(json['user'] as Map<String, dynamic>),
      messageType: json['messageType'] as String,
      isRead: json['isRead'] as bool? ?? true,
      incoming: json['incoming'] as bool? ?? false,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'message': instance.message,
      'time': instance.time.toIso8601String(),
      'user': instance.user,
      'messageType': instance.messageType,
      'isRead': instance.isRead,
      'incoming': instance.incoming,
    };
