import 'package:async/async.dart';
import 'package:cs310_group_28/models/like.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/models/comment.dart';
part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  String? postID;
  String? mediaURL;
  DateTime postTime;
  String caption;
  String location;
  String userID;
  List<String> tags;

  Post(
      {this.mediaURL,
      required this.postTime,
      required this.userID,
      this.caption = "",
      this.location = "",
      this.postID,
      this.tags = const <String>[]});

  factory Post.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;

    return Post(
        caption: data['caption'] as String,
        postTime: DateTime.parse(data['postTime'] as String),
        mediaURL: data["mediaURL"] as String?,
        location: data['location'] as String,
        userID: data['userID'] as String,
        postID: snapshot.reference.id,
        tags: data["tags"].cast<String>());
  }

  Map<String, dynamic> toFirestore() {
    return {
      "caption": caption,
      "location": location,
      "mediaURL": mediaURL,
      "postTime": postTime.toIso8601String(),
      "userID": userID,
      "tags": tags
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  Future<List<Comment>> get comments async {
    List<Comment> comments = <Comment>[];
    var commentsRef = await FirebaseFirestore.instance
        .collection("Comments")
        .where("postID", isEqualTo: postID)
        .get();
    var commentDocs = commentsRef.docs;
    for (int i = 0; i < commentDocs.length; i++) {
      comments.add(Comment.fromFirestore(commentDocs[i], null));
    }
    return comments;
  }

  Future<int> get commentsLength async {
    var commentsRef = await FirebaseFirestore.instance
        .collection("Comments")
        .where("postID", isEqualTo: postID)
        .get();
    return commentsRef.docs.length;
  }

  Future<int> get numLikes async {
    int numLikes = 0;
    FirebaseFirestore.instance
        .collection('UserLikedPost')
        .where("postID", isEqualTo: postID)
        .snapshots()
        .listen((event) {
      for (int i = 0; i < event.docs.length; i++) {
        numLikes += event.docs[i]["val"] ? 1 : -1;
      }
    });

    return numLikes;
  }

  Stream postStream() {
    Stream postStream = FirebaseFirestore.instance
        .collection('Posts')
        .doc(postID)
        .snapshots()
        .map((event) => Post.fromFirestore(event, null));
    Stream commentsStream = FirebaseFirestore.instance
        .collection('Comments')
        .where("postID", isEqualTo: postID)
        .snapshots()
        .map((event) =>
            [for (var doc in event.docs) Comment.fromFirestore(doc, null)]);
    Stream likesStream = FirebaseFirestore.instance
        .collection('UserLikedPost')
        .where("postID", isEqualTo: postID)
        .snapshots()
        .map((event) => event.docs.isNotEmpty
            ? [
                for (var doc in event.docs)
                  Like.fromFirestore(doc, null).toInt()
              ].reduce((a, b) => a + b)
            : 0);
    return StreamGroup.merge([postStream, commentsStream, likesStream]);
  }
}
