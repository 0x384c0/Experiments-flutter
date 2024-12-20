import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory User({
    required int reputation,
    required int userId,
    BadgeCount? badgeCounts,
    required String displayName,
    required String profileImage,
    required String link,
  }) = _User;

  factory User.fromJson(Map<String, Object> json) => _$UserFromJson(json);
}

@freezed
class BadgeCount with _$BadgeCount {
  factory BadgeCount({
    required int bronze,
    required int silver,
    required int gold,
  }) = _BadgeCount;

  factory BadgeCount.fromJson(Map<String, Object> json) =>
      _$BadgeCountFromJson(json);
}