import 'dart:async';

import 'package:features_common_data/interfaces/oauth_token_refresher.dart';
import 'package:features_common_data/interfaces/oauth_tokens_entity.dart';

/// This class must be a singleton, because only one token can be refreshed at time
class OAuthTokenRefresherImpl<T extends OauthTokensEntity> implements OAuthTokenRefresher<T> {
  OAuthTokenRefresherImpl(this.repository);

  final TokenRefreshRemoteRepository<T> repository;
  static const _expirationTimeLimit = Duration(minutes: 1);
  Completer<T?>? _refreshCompleter;

  @override
  Future<T?> getRefreshedTokensIfNeeded(T oldTokens) async {
    // tokens already refreshing, so thread must wait for its result
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    // try to refresh tokens
    if (await _needToRefreshTokens(oldTokens)) {
      _refreshCompleter = Completer<T?>();

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

  Future<bool> _needToRefreshTokens(T tokens) async {
    return tokens.expirationDate != null
        ? tokens.expirationDate!.difference(DateTime.now()) < _expirationTimeLimit
        : false;
  }
}

abstract class TokenRefreshRemoteRepository<T extends OauthTokensEntity> {
  Future<T?> refreshTokens(T oldTokens);
}
