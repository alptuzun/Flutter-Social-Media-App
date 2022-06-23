import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String message;
  DateTime time;
  String messageType;
  bool isRead;
  String userID;

  Message({
    required this.userID,
    required this.message,
    required this.time,
    required this.messageType,
    this.isRead = false,
  });

  factory Message.fromFirestore(
    snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Message(
      userID: data?["userID"],
      message: data?['message'],
      time: DateTime.parse(data?['time'] as String),
      messageType: data?['messageType'],
      isRead: data?["isRead"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "message": message,
      "time": time.toIso8601String(),
      "messageType": messageType,
      "isRead": isRead,
      "userID": userID
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
