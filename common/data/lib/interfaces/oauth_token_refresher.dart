import '../data/oauth_tokens_entity.dart';

abstract class OAuthTokenRefresher {
  Future<OauthTokensEntity?> getRefreshedTokensIfNeeded(OauthTokensEntity oldTokens);
}
