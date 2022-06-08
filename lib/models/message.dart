import 'package:cs310_group_28/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.g.dart';
part 'message.freezed.dart';

@unfreezed
class Message with _$Message {
  factory Message({
    required String message,
    required DateTime time,
    required MyUser user,
    required String messageType,
    @Default(true) bool isRead,
    @Default(false) bool incoming,
}) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}

