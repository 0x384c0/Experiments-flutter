import 'oauth_tokens_entity.dart';

/// Data should be stored in secure storage like [BaseSecureDao]
abstract class OAuthLocalRepository<T extends OauthTokensEntity> {
  Future<T?> getTokensEntity();

  Future setTokensEntity(T tokensEntity);

  Future removeTokens();

  Map<String, String> get headers;
}
