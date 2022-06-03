import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@unfreezed
class MyUser with _$MyUser {
  factory MyUser({
    required String username,
    required String fullName,
    required String email,
    @Default("") String bio,
    String? phone,
    @Default("assets/images/default_profile_picture.webp")
        String profilePicture,
    @Default(false) bool private,
    @Default([]) List posts,
    @Default([]) List favorites,
    @Default([]) List comments,
    @Default([]) List following,
    @Default([]) List followers,
  }) = _MyUser;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
}
