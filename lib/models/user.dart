import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/post.dart';
import 'package:json_annotation/json_annotation.dart';

import 'comment.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class MyUser {
  String username;
  String fullName;
  String bio;
  String email;
  String phone;
  String profilePicture;
  bool private;
  String userID;
  List<dynamic> notifications;
  List<String> interests;

  Future<List<Post>> get posts async {
    List<Post> posts = <Post>[];
    var postsQuery = await FirebaseFirestore.instance
        .collection("Posts")
        .where("userID", isEqualTo: userID)
        .get();
    var postDocs = postsQuery.docs;
    for (int i = 0; i < postDocs.length; i++) {
      posts.add(Post.fromFirestore(postDocs[i], null));
    }
    return posts;
  }

  Future<List<Post>> get favorites async {
    List<Post> posts = <Post>[];
    var postsQuery = await FirebaseFirestore.instance
        .collection("UserLikedPost")
        .where("userID", isEqualTo: userID)
        .where("val", isEqualTo: true)
        .get();
    var postDocs = postsQuery.docs;

    for (int i = 0; i < postDocs.length; i++) {
      var post = await FirebaseFirestore.instance
          .collection("Posts")
          .doc(postDocs[i].data()["postID"])
          .get();
      posts.add(Post.fromFirestore(post, null));
    }
    return posts;
  }

  List<Comment> get comments {
    List<Comment> comments = <Comment>[];
    FirebaseFirestore.instance
        .collection("Comments")
        .where("userID", isEqualTo: userID)
        .get()
        .then((c) => {
              for (int i = 0; i < c.docs.length; i++)
                {comments.add(Comment.fromFirestore(c.docs[i], null))}
            });
    return comments;
  }

  Future<List<MyUser>> get followers async {
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

  Future<List<MyUser>> get following async {
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

  MyUser(
      {required this.username,
      required this.fullName,
      required this.email,
      required this.userID,
      this.bio = "",
      this.phone = "",
      this.profilePicture =
          "https://firebasestorage.googleapis.com/v0/b/cs310-group-28.appspot.com/o/blank_pfp.png?alt=media&token=5d0aef19-82e7-4519-b545-7360e8b1a249",
      this.private = false,
      this.notifications = const [],
      this.interests = const []});

  factory MyUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MyUser(
        notifications: data?["notifications"] is Iterable
            ? List.from(data?["notifications"])
            : [],
        userID: snapshot.reference.id,
        username: data?['username'],
        fullName: data?['fullName'],
        email: data?['email'],
        bio: data?['bio'],
        phone: data?['phone'],
        profilePicture: data?["profilePicture"],
        private: data?['private'],
        interests: data?["interests"].cast<String>());
  }

  Map<String, dynamic> toFirestore() {
    return {
      "username": username,
      "fullName": fullName,
      "email": email,
      "bio": bio,
      "phone": phone,
      "profilePicture": profilePicture,
      "private": private,
      "userID": userID,
      "notifications": notifications,
      "interests": interests
    };
  }

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
