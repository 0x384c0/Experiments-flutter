import 'package:common_data/interfaces/oauth_local_repository.dart';
import 'package:common_data/interfaces/oauth_token_refresher.dart';
import 'package:common_data/interfaces/oauth_tokens_entity.dart';
import 'package:dio/dio.dart';

class OauthInterceptor<T extends OauthTokensEntity> extends Interceptor {
  OauthInterceptor(this._tokensProvider, this._tokenRefresher);

  static int unauthorizedCode = 401;

  final OAuthLocalRepository<T> _tokensProvider;
  final OAuthTokenRefresher<T> _tokenRefresher;

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (await _tokensProvider.getTokensEntity() case var tokens?) {
      if (await _tokenRefresher.getRefreshedTokensIfNeeded(tokens) case var newTokens?) {
        await _tokensProvider.setTokensEntity(newTokens);
      }
    }
    options.headers.addAll(_tokensProvider.headers);
    handler.next(options);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == unauthorizedCode) {
      handler.next(DioException(error: unauthorizedCode, requestOptions: err.requestOptions));
    } else {
      handler.next(err);
    }
  }
}
