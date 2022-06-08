// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  String get postID => throw _privateConstructorUsedError;
  set postID(String value) => throw _privateConstructorUsedError;
  String get userID => throw _privateConstructorUsedError;
  set userID(String value) => throw _privateConstructorUsedError;
  DateTime get postTime => throw _privateConstructorUsedError;
  set postTime(DateTime value) => throw _privateConstructorUsedError;
  MyUser get user => throw _privateConstructorUsedError;
  set user(MyUser value) => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  set caption(String? value) => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  set location(String? value) => throw _privateConstructorUsedError;
  String get imageName => throw _privateConstructorUsedError;
  set imageName(String value) => throw _privateConstructorUsedError;
  List<dynamic> get likes => throw _privateConstructorUsedError;
  set likes(List<dynamic> value) => throw _privateConstructorUsedError;
  List<dynamic> get comments => throw _privateConstructorUsedError;
  set comments(List<dynamic> value) => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  set price(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res>;
  $Res call(
      {String postID,
      String userID,
      DateTime postTime,
      MyUser user,
      String? caption,
      String? location,
      String imageName,
      List<dynamic> likes,
      List<dynamic> comments,
      String? price});

  $MyUserCopyWith<$Res> get user;
}

/// @nodoc
class _$PostCopyWithImpl<$Res> implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  final Post _value;
  // ignore: unused_field
  final $Res Function(Post) _then;

  @override
  $Res call({
    Object? postID = freezed,
    Object? userID = freezed,
    Object? postTime = freezed,
    Object? user = freezed,
    Object? caption = freezed,
    Object? location = freezed,
    Object? imageName = freezed,
    Object? likes = freezed,
    Object? comments = freezed,
    Object? price = freezed,
  }) {
    return _then(_value.copyWith(
      postID: postID == freezed
          ? _value.postID
          : postID // ignore: cast_nullable_to_non_nullable
              as String,
      userID: userID == freezed
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      postTime: postTime == freezed
          ? _value.postTime
          : postTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as MyUser,
      caption: caption == freezed
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      imageName: imageName == freezed
          ? _value.imageName
          : imageName // ignore: cast_nullable_to_non_nullable
              as String,
      likes: likes == freezed
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      comments: comments == freezed
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $MyUserCopyWith<$Res> get user {
    return $MyUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$$_PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$_PostCopyWith(_$_Post value, $Res Function(_$_Post) then) =
      __$$_PostCopyWithImpl<$Res>;
  @override
  $Res call(
      {String postID,
      String userID,
      DateTime postTime,
      MyUser user,
      String? caption,
      String? location,
      String imageName,
      List<dynamic> likes,
      List<dynamic> comments,
      String? price});

  @override
  $MyUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_PostCopyWithImpl<$Res> extends _$PostCopyWithImpl<$Res>
    implements _$$_PostCopyWith<$Res> {
  __$$_PostCopyWithImpl(_$_Post _value, $Res Function(_$_Post) _then)
      : super(_value, (v) => _then(v as _$_Post));

  @override
  _$_Post get _value => super._value as _$_Post;

  @override
  $Res call({
    Object? postID = freezed,
    Object? userID = freezed,
    Object? postTime = freezed,
    Object? user = freezed,
    Object? caption = freezed,
    Object? location = freezed,
    Object? imageName = freezed,
    Object? likes = freezed,
    Object? comments = freezed,
    Object? price = freezed,
  }) {
    return _then(_$_Post(
      postID: postID == freezed
          ? _value.postID
          : postID // ignore: cast_nullable_to_non_nullable
              as String,
      userID: userID == freezed
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      postTime: postTime == freezed
          ? _value.postTime
          : postTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as MyUser,
      caption: caption == freezed
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      imageName: imageName == freezed
          ? _value.imageName
          : imageName // ignore: cast_nullable_to_non_nullable
              as String,
      likes: likes == freezed
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      comments: comments == freezed
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Post implements _Post {
  _$_Post(
      {required this.postID,
      required this.userID,
      required this.postTime,
      required this.user,
      this.caption,
      this.location,
      required this.imageName,
      this.likes = const [],
      this.comments = const [],
      this.price});

  factory _$_Post.fromJson(Map<String, dynamic> json) => _$$_PostFromJson(json);

  @override
  String postID;
  @override
  String userID;
  @override
  DateTime postTime;
  @override
  MyUser user;
  @override
  String? caption;
  @override
  String? location;
  @override
  String imageName;
  @override
  @JsonKey()
  List<dynamic> likes;
  @override
  @JsonKey()
  List<dynamic> comments;
  @override
  String? price;

  @override
  String toString() {
    return 'Post(postID: $postID, userID: $userID, postTime: $postTime, user: $user, caption: $caption, location: $location, imageName: $imageName, likes: $likes, comments: $comments, price: $price)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_PostCopyWith<_$_Post> get copyWith =>
      __$$_PostCopyWithImpl<_$_Post>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostToJson(this);
  }
}

abstract class _Post implements Post {
  factory _Post(
      {required String postID,
      required String userID,
      required DateTime postTime,
      required MyUser user,
      String? caption,
      String? location,
      required String imageName,
      List<dynamic> likes,
      List<dynamic> comments,
      String? price}) = _$_Post;

  factory _Post.fromJson(Map<String, dynamic> json) = _$_Post.fromJson;

  @override
  String get postID => throw _privateConstructorUsedError;
  @override
  String get userID => throw _privateConstructorUsedError;
  @override
  DateTime get postTime => throw _privateConstructorUsedError;
  @override
  MyUser get user => throw _privateConstructorUsedError;
  @override
  String? get caption => throw _privateConstructorUsedError;
  @override
  String? get location => throw _privateConstructorUsedError;
  @override
  String get imageName => throw _privateConstructorUsedError;
  @override
  List<dynamic> get likes => throw _privateConstructorUsedError;
  @override
  List<dynamic> get comments => throw _privateConstructorUsedError;
  @override
  String? get price => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PostCopyWith<_$_Post> get copyWith => throw _privateConstructorUsedError;
}
