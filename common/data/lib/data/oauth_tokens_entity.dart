import 'package:freezed_annotation/freezed_annotation.dart';

part 'oauth_tokens_entity.freezed.dart';

part 'oauth_tokens_entity.g.dart';

@freezed
class OauthTokensEntity with _$OauthTokensEntity {
  factory OauthTokensEntity({
    required String accessToken,
    String? refreshToken,
    // ignore: invalid_annotation_target
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson) DateTime? expirationDate,
  }) = _OauthTokensEntity;

  factory OauthTokensEntity.fromJson(Map<String, dynamic> json) => _$OauthTokensEntityFromJson(json);
}

DateTime? _dateFromJson(int? value) => value != null ? DateTime.fromMillisecondsSinceEpoch(value) : null;

int? _dateToJson(DateTime? time) => time?.millisecondsSinceEpoch;
