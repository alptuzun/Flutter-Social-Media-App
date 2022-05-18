import 'package:cs310_group_28/models/user.dart';

class Message{
  String message;
  String time_ago;
  User user;
  String message_type;
  bool? IsRead = true;
  bool? incoming = false;


  Message({
  required this.message,
  required this.time_ago,
  required this.user,
  required this.message_type,
  this.IsRead,
  this.incoming,
  });


}