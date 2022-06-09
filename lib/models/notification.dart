import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class MyNotification {
  String text;
  DateTime date;
  bool isSeen;

  MyNotification({
    required this.text,
    required this.date,
    this.isSeen = false,
  });

  factory MyNotification.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return MyNotification(
      text: data?['text'],
      date: data?['date'],
      isSeen: data?['isSeen']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'text': text,
      "date": date,
      "isSeen": isSeen,
    };
  }

  factory MyNotification.fromJson(Map<String, dynamic> json) => _$MyNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$MyNotificationToJson(this);
}