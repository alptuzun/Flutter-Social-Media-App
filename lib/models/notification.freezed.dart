// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyNotification _$MyNotificationFromJson(Map<String, dynamic> json) {
  return _MyNotification.fromJson(json);
}

/// @nodoc
mixin _$MyNotification {
  String get text => throw _privateConstructorUsedError;
  set text(String value) => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  set date(DateTime value) => throw _privateConstructorUsedError;
  bool get isSeen => throw _privateConstructorUsedError;
  set isSeen(bool value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyNotificationCopyWith<MyNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyNotificationCopyWith<$Res> {
  factory $MyNotificationCopyWith(
          MyNotification value, $Res Function(MyNotification) then) =
      _$MyNotificationCopyWithImpl<$Res>;
  $Res call({String text, DateTime date, bool isSeen});
}

/// @nodoc
class _$MyNotificationCopyWithImpl<$Res>
    implements $MyNotificationCopyWith<$Res> {
  _$MyNotificationCopyWithImpl(this._value, this._then);

  final MyNotification _value;
  // ignore: unused_field
  final $Res Function(MyNotification) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? date = freezed,
    Object? isSeen = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSeen: isSeen == freezed
          ? _value.isSeen
          : isSeen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_MyNotificationCopyWith<$Res>
    implements $MyNotificationCopyWith<$Res> {
  factory _$$_MyNotificationCopyWith(
          _$_MyNotification value, $Res Function(_$_MyNotification) then) =
      __$$_MyNotificationCopyWithImpl<$Res>;
  @override
  $Res call({String text, DateTime date, bool isSeen});
}

/// @nodoc
class __$$_MyNotificationCopyWithImpl<$Res>
    extends _$MyNotificationCopyWithImpl<$Res>
    implements _$$_MyNotificationCopyWith<$Res> {
  __$$_MyNotificationCopyWithImpl(
      _$_MyNotification _value, $Res Function(_$_MyNotification) _then)
      : super(_value, (v) => _then(v as _$_MyNotification));

  @override
  _$_MyNotification get _value => super._value as _$_MyNotification;

  @override
  $Res call({
    Object? text = freezed,
    Object? date = freezed,
    Object? isSeen = freezed,
  }) {
    return _then(_$_MyNotification(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSeen: isSeen == freezed
          ? _value.isSeen
          : isSeen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyNotification implements _MyNotification {
  _$_MyNotification(
      {required this.text, required this.date, this.isSeen = false});

  factory _$_MyNotification.fromJson(Map<String, dynamic> json) =>
      _$$_MyNotificationFromJson(json);

  @override
  String text;
  @override
  DateTime date;
  @override
  @JsonKey()
  bool isSeen;

  @override
  String toString() {
    return 'MyNotification(text: $text, date: $date, isSeen: $isSeen)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_MyNotificationCopyWith<_$_MyNotification> get copyWith =>
      __$$_MyNotificationCopyWithImpl<_$_MyNotification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyNotificationToJson(this);
  }
}

abstract class _MyNotification implements MyNotification {
  factory _MyNotification(
      {required String text,
      required DateTime date,
      bool isSeen}) = _$_MyNotification;

  factory _MyNotification.fromJson(Map<String, dynamic> json) =
      _$_MyNotification.fromJson;

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  DateTime get date => throw _privateConstructorUsedError;
  @override
  bool get isSeen => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MyNotificationCopyWith<_$_MyNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
