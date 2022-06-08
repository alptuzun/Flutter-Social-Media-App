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
    @Default("https://firebasestorage.googleapis.com/v0/b/cs310-group-28.appspot.com/o/blank_pfp.png?alt=media&token=5d0aef19-82e7-4519-b545-7360e8b1a249")
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
