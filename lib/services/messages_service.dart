import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/message.dart';

String _getDocID(String id1, String id2) {
  if (id1.compareTo(id2) < 0) {
    return "$id1-$id2";
  }
  return "$id2-$id1";
}

class MessageService {
  static Stream getMessages(String user, String userToText) {
    String docID = _getDocID(user, userToText);
    return FirebaseFirestore.instance
        .collection("Messages")
        .doc(docID)
        .collection("messages")
        .snapshots();
  }

  static Future<void> sendMessage(Message m, String userToText) async {
    String docID = _getDocID(m.userID, userToText);
    await FirebaseFirestore.instance
        .collection("Messages")
        .doc(docID)
        .collection("messages")
        .add(m.toFirestore());
    await FirebaseFirestore.instance.collection("Messages").doc(docID).set({
      "userIDs": [m.userID, userToText]
    });
  }

  static Stream getAllMessages(String userID) {
    return FirebaseFirestore.instance
        .collection("Messages")
        .where("userIDs", arrayContains: userID)
        .snapshots();
  }
}
