import 'package:cs310_group_28/models/user.dart';

class Message {
  String message;
  String timeAgo;
  User user;
  String messageType;
  bool? isRead = true;
  bool? incoming = false;

  Message({
    required this.message,
    required this.timeAgo,
    required this.user,
    required this.messageType,
    this.isRead,
    this.incoming,
  });
}
