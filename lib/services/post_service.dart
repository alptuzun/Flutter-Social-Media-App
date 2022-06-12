import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostService {
  static returnRef() => FirebaseFirestore.instance.collection("Posts");

  static Future<String> uploadToFirebaseImage(
      User? user, File image, String postID) async {
    var storage =
        FirebaseStorage.instance.ref().child("userPosts/${user!.uid}/$postID");
    var upload = await storage.putFile(image);
    String postLink = await upload.ref.getDownloadURL();
    return postLink;
  }

  static Future<String> uploadToFirebaseVideo(
      User? user, File video, String postID) async {
    var storage =
        FirebaseStorage.instance.ref().child("userPosts/${user!.uid}/$postID");
    var upload = await storage.putFile(video);
    String postLink = await upload.ref.getDownloadURL();
    return postLink;
  }

  static publishPost(String userID, Post newPost) async {
    FirebaseFirestore.instance.collection('Users').doc(userID).update({
      "posts": FieldValue.arrayUnion([newPost.toFirestore()])
    });
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(newPost.postID)
        .set(newPost.toFirestore());
  }

  static editPost(String userID, String postID, String text) async {
    var docRef =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    var userPosts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = userPosts[0];
    int idx = 0;
    for (; idx < userPosts.length; idx++) {
      if (postID == userPosts[idx]["postID"]) {
        thePost = userPosts[idx];
        break;
      }
    }
    thePost["caption"] = text;
    userPosts[idx] = thePost;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .update({'posts': userPosts});
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postID)
        .update({"caption": text});
  }

  static deletePost(String userID, Map<String, dynamic> post) async {
    var docRef =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();
    var userPosts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = userPosts[0];
    int idx = 0;
    for (; idx < userPosts.length; idx++) {
      if (post["postID"] == userPosts[idx]["postID"]) {
        thePost = userPosts[idx];
        break;
      }
    }
    await FirebaseFirestore.instance.collection('Users').doc(userID).update({
      "posts": FieldValue.arrayRemove([thePost])
    });
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(post["postID"].toString())
        .delete();
  }

  static likePost(String userId, String otherUserId, String postId) async {
    var docRef = await FirebaseFirestore.instance.collection('Users').doc(otherUserId).get();
    var userPosts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = userPosts[0];
    int i = 0;
    for (; i < userPosts.length; i++) {
      if (postId == userPosts[i]["postId"]) {
        thePost = userPosts[i];
        break;
      }
    }
    if (!thePost["likes"].contains(userId)) {
      thePost["likes"] = thePost["likes"] + [userId];
      userPosts[i] = thePost;
      FirebaseFirestore.instance.collection('Users').doc(otherUserId).update({"posts": userPosts});
       // UserServices().pushNotifications(userId, otherUserId, "likedPost");
    } else {
      thePost["likes"].remove(userId);
      userPosts[i] = thePost;
      FirebaseFirestore.instance.collection('Users').doc(otherUserId).update({"posts": userPosts});
    }
    var docRefPost = await FirebaseFirestore.instance
        .collection('Posts').doc(postId).get();
    if (!docRefPost["likes"].contains(userId)) {
      FirebaseFirestore.instance
          .collection('Posts').doc(postId).update({
        "likes": FieldValue.arrayUnion([userId])
      });
    } else {
      FirebaseFirestore.instance
          .collection('Posts').doc(postId).update({
        "likes": FieldValue.arrayRemove([userId])
      });
    }
  }

  static dislikePost(String userId, String otherUserId, String postId) async {
    var docRef = await FirebaseFirestore.instance.collection('Users').doc(otherUserId).get();
    var userPosts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = userPosts[0];
    int i = 0;
    for (; i < userPosts.length; i++) {
      if (postId == userPosts[i]["postId"]) {
        thePost = userPosts[i];
        break;
      }
    }
    if (!thePost["dislikes"].contains(userId)) {
      thePost["dislikes"] = thePost["dislikes"] + [userId];
      userPosts[i] = thePost;
      FirebaseFirestore.instance.collection('Users').doc(otherUserId).update({"posts": userPosts});
    } else {
      thePost["dislikes"].remove(userId);
      userPosts[i] = thePost;
      FirebaseFirestore.instance.collection('Users').doc(otherUserId).update({"posts": userPosts});
    }
    var docRefPost = await FirebaseFirestore.instance
        .collection('Posts').doc(postId).get();
    if (!docRefPost["dislikes"].contains(userId)) {
      FirebaseFirestore.instance
          .collection('Posts').doc(postId).update({
        "dislikes": FieldValue.arrayUnion([userId])
      });
    } else {
      FirebaseFirestore.instance
          .collection('Posts').doc(postId).update({
        "dislikes": FieldValue.arrayRemove([userId])
      });
    }
  }
}
