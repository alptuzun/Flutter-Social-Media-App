import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.g.dart';
part 'notification.freezed.dart';

@unfreezed
class MyNotification with _$MyNotification {
  factory MyNotification({
    required String text,
    required DateTime date,
    @Default(false) bool isSeen,
}) = _MyNotification;

  factory MyNotification.fromJson(Map<String, dynamic> json) => _$MyNotificationFromJson(json);
}

