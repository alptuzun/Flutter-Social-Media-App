import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';

class UserService {
  static void addPost(MyUser user, Post p) {
    user.posts.add(p);
  }

  static void setPrivate(MyUser user, bool val, String userID) {
    final CollectionReference usersRef =
    FirebaseFirestore.instance.collection("Users");
    usersRef.doc(userID).update({"private" : val});
  }

  static Future<String> fetchUsername(String userID) async {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection('Users');
    var ref = await usersRef.doc(userID).get();
    var user = ref.data() as Map<String, dynamic>;
    var username = user["username"];
    return username;
  }

  static Future registerUser(
      String username, String fullName, String userID, String email) async {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection("Users");
    await usersRef.doc(userID).set({
      "username": username,
      "userID": userID,
      "bio": "",
      "email": email,
      "fullName": fullName,
      "private": false,
      "phone": "",
      "profilePicture":
          "https://firebasestorage.googleapis.com/v0/b/cs310-group-28.appspot.com/o/blank_pfp.png?alt=media&token=5d0aef19-82e7-4519-b545-7360e8b1a249",
      "posts": [],
      "favorites": [],
      "comments": [],
      "following": [],
      "followers": [],
      "notifications": []
    });
  }

  static returnRef() => FirebaseFirestore.instance.collection("Users");

  static getUsername(String userID) async {
    var ref = await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    var data = ref.data() as Map<String, dynamic>;
    var uname = data["username"];
    return uname;
  }

}
