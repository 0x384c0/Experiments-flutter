import 'oauth_tokens_entity.dart';

abstract class OAuthTokenRefresher<T extends OauthTokensEntity> {
  Future<T?> getRefreshedTokensIfNeeded(T oldTokens);
}
