import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/comment.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostService {
  static returnRef() => FirebaseFirestore.instance.collection("Posts");

  static Future<String> uploadToFirebaseImage(
      String userID, File image, String postID) async {
    var storage =
        FirebaseStorage.instance.ref().child("userPosts/$userID/$postID");
    var upload = await storage.putFile(image);
    String postLink = await upload.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(postID)
        .update({"mediaURL": postLink});
    return postLink;
  }

  static publishPost(Post newPost) async {
    var docRef = await FirebaseFirestore.instance
        .collection('Posts')
        .add(newPost.toFirestore());
    return docRef.id;
  }

  static editPost(String userID, String postID, String text) async {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postID)
        .update({"caption": text});
  }

  static deletePost(String userID, Post post) async {
    // delete the post image
    if (post.mediaURL != null) {
      await FirebaseStorage.instance
          .ref()
          .child("userPosts/$userID/${post.postID}")
          .delete();
    }
    // delete the comments about the post
    var posts = await FirebaseFirestore.instance
        .collection("Comments")
        .where("postID", isEqualTo: post.postID)
        .get();
    var postDocs = posts.docs;
    for (var postDoc in postDocs) {
      postDoc.reference.delete();
    }
    // delete the likes of the post
    var likes = await FirebaseFirestore.instance
        .collection("UserLikedPost")
        .where("postID", isEqualTo: post.postID)
        .get();
    var likeDocs = likes.docs;
    for (var likeDoc in likeDocs) {
      likeDoc.reference.delete();
    }
    // delete the post itself
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(post.postID.toString())
        .delete();
  }

  static likePost(String userID, String postID) async {
    var like = await FirebaseFirestore.instance
        .collection('UserLikedPost')
        .doc("$userID-$postID")
        .get();
    if (like.exists && like.get("val")) {
      like.reference.delete();
    } else {
      like.reference.set({"userID": userID, "postID": postID, "val": true});
    }
  }

  static dislikePost(String userID, String postID) async {
    var like = await FirebaseFirestore.instance
        .collection('UserLikedPost')
        .doc("$userID-$postID")
        .get();
    if (like.exists && !like.get("val")) {
      like.reference.delete();
    } else {
      like.reference.set({"userID": userID, "postID": postID, "val": false});
    }
  }

  static Future commentToPost(Comment comment, String ownerID) async {
    await FirebaseFirestore.instance
        .collection("Comments")
        .add(comment.toFirestore());
    UserService.sendNotifications(comment.userID, ownerID, "comment");
  }
}
