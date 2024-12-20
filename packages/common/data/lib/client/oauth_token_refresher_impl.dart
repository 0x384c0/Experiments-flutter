import 'dart:async';

import 'package:common_data/interfaces/oauth_token_refresher.dart';
import 'package:common_data/interfaces/oauth_tokens_entity.dart';

/// This class must be a singleton, because only one token can be refreshed at time
class OAuthTokenRefresherImpl implements OAuthTokenRefresher {
  OAuthTokenRefresherImpl(this.repository);

  final TokenRefreshRemoteRepository repository;
  static const _expirationTimeLimit = Duration(minutes: 1);
  Completer<OauthTokensEntity?>? _refreshCompleter;

  @override
  Future<OauthTokensEntity?> getRefreshedTokensIfNeeded(OauthTokensEntity oldTokens) async {
    if (_refreshCompleter != null) {
      // tokens already refreshing, so thread must wait for its result
      return _refreshCompleter!.future.onError((e, s) => null);
    }

    // try to refresh tokens
    if (await _needToRefreshTokens(oldTokens)) {
      _refreshCompleter = Completer<OauthTokensEntity?>();

      try {
        final newTokens = await repository.refreshTokens(oldTokens);
        _refreshCompleter?.complete(newTokens);
        return newTokens;
      } catch (error) {
        _refreshCompleter?.completeError(error); // Complete with an error
      } finally {
        _refreshCompleter = null; // Reset Completer after usage
      }
    }

    // tokens are not refreshed
    return null;
  }

  Future<bool> _needToRefreshTokens(OauthTokensEntity tokens) async {
    return tokens.expirationDate != null
        ? tokens.expirationDate!.difference(DateTime.now()) < _expirationTimeLimit
        : false;
  }
}

abstract class TokenRefreshRemoteRepository {
  Future<OauthTokensEntity?> refreshTokens(OauthTokensEntity oldTokens);
}
