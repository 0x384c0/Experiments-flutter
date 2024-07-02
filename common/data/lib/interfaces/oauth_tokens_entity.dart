abstract interface class OauthTokensEntity {
  String get accessToken;

  String? get refreshToken;

  DateTime? get expirationDate;
}