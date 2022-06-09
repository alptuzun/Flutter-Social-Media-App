import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String message;
  DateTime time;
  String username;
  String fullName;
  String messageType;
  bool isRead;
  bool incoming;

  Message({
    required this.fullName,
    required this.message,
    required this.username,
    required this.time,
    required this.messageType,
    required this.incoming,
    this.isRead = false,
  });

  factory Message.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Message(
      fullName: data?["fullName"],
      username: data?['username'],
      message: data?['message'],
      time: DateTime.parse(data?['time'] as String),
      messageType: data?['messageType'],
      incoming: data?['incoming'],
      isRead: data?["isRead"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "username": username,
      "message": message,
      "time": time.toIso8601String(),
      "messageType": messageType,
      "incoming": incoming,
      "isRead": isRead,
      "fullName" : fullName,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

}
