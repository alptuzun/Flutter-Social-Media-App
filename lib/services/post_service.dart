import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/comment.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/services/user_service.dart';
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

  static likePost(String userID, String otherUserID, String postId) async {
    var docRef = await FirebaseFirestore.instance
        .collection('Users')
        .doc(otherUserID)
        .get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for (; i < posts.length; i++) {
      if (postId == posts[i]["postID"]) {
        thePost = posts[i];
        break;
      }
    }
    if (!thePost["likes"].contains(userID)) {
      thePost["likes"] = thePost["likes"] + [userID];
      posts[i] = thePost;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(otherUserID)
          .update({"posts": posts});
      if (userID != otherUserID) {
        UserService.sendNotifications(userID, otherUserID, "like");
      }
    } else {
      thePost["likes"].remove(userID);
      posts[i] = thePost;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(otherUserID)
          .update({"posts": posts});
    }
    var docRefPost =
        await FirebaseFirestore.instance.collection('Posts').doc(postId).get();
    if (!docRefPost["likes"].contains(userID)) {
      FirebaseFirestore.instance.collection('Posts').doc(postId).update({
        "likes": FieldValue.arrayUnion([userID])
      });
    } else {
      FirebaseFirestore.instance.collection('Posts').doc(postId).update({
        "likes": FieldValue.arrayRemove([userID])
      });
    }
  }

  static dislikePost(String userID, String otherUserID, String postID) async {
    var docRef = await FirebaseFirestore.instance
        .collection('Users')
        .doc(otherUserID)
        .get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for (; i < posts.length; i++) {
      if (postID == posts[i]["postID"]) {
        thePost = posts[i];
        break;
      }
    }
    if (!thePost["dislikes"].contains(userID)) {
      thePost["dislikes"] = thePost["dislikes"] + [userID];
      posts[i] = thePost;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(otherUserID)
          .update({"posts": posts});
      if (userID != otherUserID) {
        UserService.sendNotifications(userID, otherUserID, "dislike");
      }
    } else {
      thePost["dislikes"].remove(userID);
      posts[i] = thePost;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(otherUserID)
          .update({"posts": posts});
    }
    var docRefPost =
        await FirebaseFirestore.instance.collection('Posts').doc(postID).get();
    if (!docRefPost["dislikes"].contains(userID)) {
      FirebaseFirestore.instance.collection('Posts').doc(postID).update({
        "dislikes": FieldValue.arrayUnion([userID])
      });
    } else {
      FirebaseFirestore.instance.collection('Posts').doc(postID).update({
        "dislikes": FieldValue.arrayRemove([userID])
      });
    }
  }

  static Future commentToPost(
      String userID, String otherUserID, String postID, Comment comment) async {
    var docRef = await FirebaseFirestore.instance
        .collection('Users')
        .doc(otherUserID)
        .get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for (; i < posts.length; i++) {
      if (postID == posts[i]["postID"]) {
        thePost = posts[i];
        break;
      }
    }
    thePost["comments"] = thePost["comments"] + [comment.toJson()];
    posts[i] = thePost;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(otherUserID)
        .update({"posts": posts});
    FirebaseFirestore.instance.collection('Posts').doc(postID).update({
      "comments": FieldValue.arrayUnion([comment.toJson()])
    });
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userID).update({"comments" : FieldValue.arrayUnion([comment.toJson()])});
    UserService.sendNotifications(userID, otherUserID, "comment");
  }

}
