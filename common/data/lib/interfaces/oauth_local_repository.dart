import '../data/oauth_tokens_entity.dart';

/// Data should be stored in secure storage like [BaseSecureDao]
abstract class OAuthLocalRepository {
  Future<OauthTokensEntity?> getTokensEntity();

  Future setTokensEntity(OauthTokensEntity tokensEntity);

  Future removeTokens();

  Map<String, String> get headers;
}
