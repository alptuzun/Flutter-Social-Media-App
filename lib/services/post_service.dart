import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostService {

  static returnRef() => FirebaseFirestore.instance.collection("Posts");

  static Future<String> uploadToFirebaseImage(User? user, File image, String postID) async {
    var storage = FirebaseStorage.instance.ref().child("userPosts/${user!.uid}/$postID");
    var upload = await storage.putFile(image);
    String postLink = await upload.ref.getDownloadURL();
    return postLink;
  }

  static Future<String> uploadToFirebaseVideo(User? user, File video, String postID) async {
    var storage = FirebaseStorage.instance.ref().child("userPosts/${user!.uid}/$postID");
    var upload = await storage.putFile(video);
    String postLink = await upload.ref.getDownloadURL();
    return postLink;
  }

  static publishPost(String userID, Post newPost) async {
    FirebaseFirestore.instance.collection('Users').doc(userID).update({
      "posts" : FieldValue.arrayUnion([newPost.toFirestore()])
    });
    FirebaseFirestore.instance.collection('Posts').doc(newPost.postID).set(newPost.toFirestore());
  }


}