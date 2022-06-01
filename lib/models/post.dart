import 'package:cs310_group_28/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.g.dart';
part 'post.freezed.dart';

@unfreezed
class Post with _$Post {
  factory Post({
    required User user,
    String? caption,
    required String date,
    String? location,
    required String imageName,
    @Default([]) List likes,
    @Default([]) List comments,
    String? price,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
