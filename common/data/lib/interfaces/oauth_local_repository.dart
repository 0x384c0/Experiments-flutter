import '../data/oauth_tokens_entity.dart';

abstract class OAuthLocalRepository {
  Future<OauthTokensEntity?> getTokensEntity();

  Future setTokensEntity(OauthTokensEntity tokensEntity);

  Future removeTokens();

  Map<String, String> get headers;
}
