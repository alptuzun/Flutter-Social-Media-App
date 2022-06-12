import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/notification.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UserService {
  static void addPost(MyUser user, Post p) {
    user.posts.add(p);
  }

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
      "posts": [],
      "favorites": [],
      "comments": [],
      "following": [],
      "followers": [],
      "notifications": []
    });
  }

  static Future<bool> isFollowing({
    required String uid,
    required String followingUserID,
  }) async {
    followingUserID = followingUserID.replaceAll(' ', '');
    try {
      DocumentSnapshot ds =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      List followers = (ds.data()! as dynamic)['following'];

      if (followers.contains(followingUserID)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  static Future<void> followUser(
    String uid,
    String followinguserid,
  ) async {
    followinguserid = followinguserid.replaceAll(' ', '');
    if (uid != followinguserid) {
      try {
        DocumentSnapshot ds =
            await FirebaseFirestore.instance.collection('Users').doc(uid).get();
        List following = (ds.data()! as dynamic)['following'];

        if (following.contains(followinguserid)) {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(followinguserid)
              .update({
            'followers': FieldValue.arrayRemove([uid])
          });
          await FirebaseFirestore.instance.collection('Users').doc(uid).update({
            'following': FieldValue.arrayRemove([followinguserid])
          });
        } else {
          if ((ds.data() as dynamic)['private'] == 'true') {
            UserService.sendNotifications(uid, followinguserid, "follow");
          } else {
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(followinguserid)
                .update({
              'followers': FieldValue.arrayUnion([uid])
            });
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(uid)
                .update({
              'following': FieldValue.arrayUnion([followinguserid])
            });
          }
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  static getFollowings(String userID) async {
    var ref =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    var data = ref.data() as Map<String, dynamic>;
    var uname = data["following"];
    return uname;
  }

  static getFollowers(String userID) async {
    var ref =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    var data = ref.data() as Map<String, dynamic>;
    var uname = data["followers"];
    return uname;
  }

  static getAllUsers() async {
    List<MyUser> myList = [];
    var documentSnapshot =
        await FirebaseFirestore.instance.collection("Users").get();
    var allUsers = documentSnapshot.docs.map((doc) => doc.data()).toList();
    int userCount = await usersLength();
    for (int i = 0; i < userCount; i++) {
      MyUser users = MyUser(
        userID: allUsers[i]["userID"],
        username: allUsers[i]['username'],
        fullName: allUsers[i]['fullName'],
        email: allUsers[i]['email'],
        bio: allUsers[i]['bio'] ?? "",
        phone: allUsers[i]['phone'] ?? "",
        profilePicture: allUsers[i]["profilePicture"] ?? "",
        private: allUsers[i]['private'],
        comments: allUsers[i]['comments'] is Iterable
            ? List.from(allUsers[i]['comments'])
            : [],
        posts: allUsers[i]['posts'] is Iterable
            ? List.from(allUsers[i]['posts'])
            : [],
        following: allUsers[i]['following'] is Iterable
            ? List.from(allUsers[i]['following'])
            : [],
        followers: allUsers[i]['followers'] is Iterable
            ? List.from(allUsers[i]['followers'])
            : [],
        favorites: allUsers[i]['favorites'] is Iterable
            ? List.from(allUsers[i]['favorites'])
            : [],
      );
      myList.add(users);
    }
    return myList;
  }

  static usersLength() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection("Users").get();
    final int allUsersCount = querySnapshot.docs.length;
    return allUsersCount;
  }

  static returnRef() => FirebaseFirestore.instance.collection("Users");

  static getUsername(String userID) async {
    var ref =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    var data = ref.data() as Map<String, dynamic>;
    var uname = data["username"];
    return uname;
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

  static remove_from_followers(String uid, aUser) async {
    try {
      DocumentSnapshot ds =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      List following = (ds.data()! as dynamic)['followers'];

      await FirebaseFirestore.instance.collection('Users').doc(uid).update({
        'followers': FieldValue.arrayRemove([aUser])
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
