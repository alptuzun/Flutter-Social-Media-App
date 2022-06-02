import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';

class UserService {
  static void addPost(User user, Post p) {
    user.posts.add(p);
  }

  static void setPrivate(User user, bool val) {
    user.private = val;
  }

  static Future<String> fetchUsername(String userID) async {
    final CollectionReference usersRef = FirebaseFirestore.instance.collection('Users');
    var ref = await usersRef.doc("ww7kadAu7ccLNLKHrT4n9aygNWH3"
    ).get();
    var user = ref.data() as Map<String, dynamic>;
    var username = user["username"];
    return username;
  }
}
