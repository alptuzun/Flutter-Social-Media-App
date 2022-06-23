import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/notification.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UserService {
  static void setPrivate(MyUser user, bool val, String userID) {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection("Users");
    usersRef.doc(userID).update({"private": val});
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
      "notifications": []
    });
  }

  static Future<bool> isFollowing({
    required String uid,
    required String followingUserID,
  }) async {
    final String search = uid + '-' + followingUserID;
    try {
      var ds = await FirebaseFirestore.instance.collection('UserFollowsUser').doc(search).get();

      return ds.exists ? true : false;

    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  static Future<void> followUser(
      String uid, String uidToFollow, bool acceptRequest) async {
    uidToFollow = uidToFollow.replaceAll(' ', '');
    if (uid != uidToFollow) {
      try {
        var ref = await FirebaseFirestore.instance
            .collection('UserFollowsUser')
            .doc("$uid-$uidToFollow")
            .get();
        if (!ref.exists) {
          if (!await getPrivacy(uidToFollow) || acceptRequest) {
            await FirebaseFirestore.instance
                .collection('UserFollowsUser')
                .doc("$uid-$uidToFollow")
                .set({"follower": uid, "followedUser": uidToFollow});
          } else {
            UserService.sendNotifications(uid, uidToFollow, "privateFollow");
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<List<MyUser>> getFollowings(String userID) async {
    var data = await FirebaseFirestore.instance
        .collection('UserFollowsUser')
        .where("follower", isEqualTo: userID)
        .get();
    List<MyUser> users = <MyUser>[];
    for (int i = 0; i < data.docs.length; i++) {
      var currentUser = await FirebaseFirestore.instance
          .collection('Users')
          .doc(data.docs[i].data()["followedUser"])
          .get();
      if (currentUser.exists) {
        users.add(MyUser.fromFirestore(currentUser, null));
      }
    }
    return users;
  }

  static Future<List<MyUser>> getFollowers(String userID) async {
    var data = await FirebaseFirestore.instance
        .collection('UserFollowsUser')
        .where("followedUser", isEqualTo: userID)
        .get();
    List<MyUser> users = <MyUser>[];
    for (int i = 0; i < data.docs.length; i++) {
      var currentUser = await FirebaseFirestore.instance
          .collection('Users')
          .doc(data.docs[i].data()["follower"])
          .get();
      if (currentUser.exists) {
        users.add(MyUser.fromFirestore(currentUser, null));
      }
    }
    return users;
  }

  static getAllUsers() async {
    List<MyUser> myList = [];
    var documentSnapshot =
        await FirebaseFirestore.instance.collection("Users").get();
    var allUsers = documentSnapshot.docs.map((doc) => doc).toList();
    int userCount = await usersLength();
    for (int i = 0; i < userCount; i++) {
      MyUser users = MyUser.fromFirestore(allUsers[i], null);
      myList.add(users);
    }
    return myList;
  }
  static userFollowsUserLength() async {
    var querySnapshot =
    await FirebaseFirestore.instance.collection("UsersFollowsUser").get();
    final int  userFollowsUserLength = querySnapshot.docs.length;
    return  userFollowsUserLength;
  }
  static usersLength() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection("Users").get();
    final int allUsersCount = querySnapshot.docs.length;
    return allUsersCount;
  }

  static returnRef() => FirebaseFirestore.instance.collection("Users");

  static Future<MyUser> getUser(String userID) async {
    var ref =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    MyUser user = MyUser.fromFirestore(ref, null);
    return user;
  }

  static editBio(String userID, String newBio) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userID)
        .update({"bio": newBio});
  }

  static editUsername(String userID, String newUsername) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userID)
        .update({"username": newUsername});
  }

  static Future<bool> uniqueUsername(String username) async {
    final results = await FirebaseFirestore.instance
        .collection("Users")
        .where("username", isEqualTo: username)
        .limit(1)
        .get();
    return results.docs.isEmpty;
  }

  static setNewPic(String url, String userID) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .update({"profilePicture": url});
  }

  static Future<String> uploadToFirebase(User? user, File file) async {
    var storageRef =
        FirebaseStorage.instance.ref().child("profilePictures/${user!.uid}");
    var upload = await storageRef.putFile(file);
    String url = await upload.ref.getDownloadURL();
    return url;
  }

  static Future uploadNewPic(User? user, File image) async {
    String downloadUrl = await uploadToFirebase(user, image);
    await setNewPic(downloadUrl, user!.uid);
  }

  static setPrivacy(String userID, bool isPrivate) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .update({"private": isPrivate});
  }

  static Future<bool> getPrivacy(String userID) async {
    var ref =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    var data = ref.data() as Map<String, dynamic>;
    bool privacy = data["private"];
    return privacy;
  }

  static Future getProfilePicture(String userID) async {
    var doc =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    return doc.get("profilePicture");
  }

  static sendNotifications(
      String userID, String receiverID, String type) async {
    FirebaseFirestore.instance.collection('Users').doc(receiverID).update({
      "notifications": FieldValue.arrayUnion([
        MyNotification(userID: userID, type: type, date: DateTime.now())
            .toJson()
      ])
    });
  }

  static unFollow(String uid, String uidToUnfollow) async {
    uidToUnfollow = uidToUnfollow.replaceAll(' ', '');
    if (uid != uidToUnfollow) {
      try {
        var ref = await FirebaseFirestore.instance
            .collection('UserFollowsUser')
            .doc("$uid-$uidToUnfollow")
            .get();
        if (ref.exists) {
          await FirebaseFirestore.instance
              .collection('UserFollowsUser')
              .doc("$uid-$uidToUnfollow")
              .delete();
        }
      } catch (e) {
        return e.toString();
      }
    }
  }

  static deleteUser(String uid) async {
    await FirebaseFirestore.instance.collection('Users').doc(uid).delete();
  }

  static setInterests(String uid, List<String> interests) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .update({"interests": interests});
    } catch (e) {
      return e.toString();
    }
  }

  static Future<bool> userFollowsUser(String uid, String uidToCheck) async {
    var ref = await FirebaseFirestore.instance
        .collection('UserFollowsUser')
        .doc("$uid-$uidToCheck")
        .get();
    return ref.exists;
  }
}
