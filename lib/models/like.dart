import 'package:cloud_firestore/cloud_firestore.dart';

class Like {
  String userID;
  bool like;
  Like({required this.userID, required this.like});

  int toInt() {
    return like ? 1 : -1;
  }

  factory Like.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Like(userID: data?["userID"], like: data?["val"]);
  }
}
