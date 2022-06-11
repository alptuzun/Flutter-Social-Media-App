import 'package:cloud_firestore/cloud_firestore.dart';
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
  static getAllUsers()  async {
    var ref = FirebaseFirestore.instance.collection("Users");
    List<MyUser>  MyList = [];
    /*int a = await UsersLength();
    for(int i = 0; i< 5; i++)
    {
      final ref = FirebaseFirestore.instance
          .collection("Users")
          .doc('$i')
          .withConverter(
        fromFirestore: MyUser.fromFirestore,
        toFirestore: (MyUser currentUser, _) => currentUser.toFirestore(),
      );
      final docSnap = await ref.get();

      MyList.add(docSnap.data());
      print("For loop");


    }*/

    var DocumentSnapshot =await FirebaseFirestore.instance.collection("Users").get();
    var Allusers =  DocumentSnapshot.docs.map((doc) => doc.data()).toList();
    //var re = FirebaseFirestore.instance.collection("Users").doc('IBx8K3spDqWf5NIVo6BUsIv04Tp2').withConverter(fromFirestore: MyUser.fromFirestore, toFirestore: (MyUser currentUser, _) => currentUser.toFirestore());
    //final docSnap = await re.get();

    int userCount = await UsersLength();
    for(int i = 0; i<userCount; i++)
    {
      MyUser Users =MyUser(
        username: Allusers[i]?['username'],
        fullName: Allusers[i]?['fullName'],
        email: Allusers[i]?['email'],
        bio: Allusers[i]?['bio'] ?? "",
        phone: Allusers[i]?['phone'] ?? "",
        profilePicture: Allusers[i]?["profilePicture"] ?? "",
        private: Allusers[i]?['private'],
        /*comments: Allusers[i]?['comments'] is Iterable ? List.from(Allusers[i]?['comments']) : [],
        posts: Allusers[i]?['posts'] is Iterable ? List.from(Allusers[i]?['posts']) : [],
        following: Allusers[i]?['following'] is Iterable ? List.from(Allusers[i]?['following']) : [],
        followers: Allusers[i]?['followers'] is Iterable ? List.from(Allusers[i]?['followers']) : [],
        favorites: Allusers[i]?['favorites'] is Iterable ? List.from(Allusers[i]?['favorites']) : [],0*/
      );

      MyList.add(Users);

    }


    print('Here is coming ------');
    //print(Allusers);
    //print(docSnap.data());
    print('2- Here is coming ------');
    print(MyList);
    return MyList;


  }
  static UsersLength() async{
    var ref = FirebaseFirestore.instance.collection("Users");
    var QuerySnapshot =await FirebaseFirestore.instance.collection("Users").get();
    final int AllusersCount =  QuerySnapshot.docs.length;
    return  AllusersCount;
  }

  static returnRef() => FirebaseFirestore.instance.collection("Users");

  static getUsername(String userID) async {
    var ref = await FirebaseFirestore.instance.collection('Users').doc(userID).get();
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
    FirebaseFirestore.instance.collection('Users').doc(userID).update({"private" : isPrivate});
  }

  static Future<bool> getPrivacy(String userID) async {
    var ref = await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    var data = ref.data() as Map<String, dynamic>;
    bool privacy = data["private"];
    return privacy;
  }

}
