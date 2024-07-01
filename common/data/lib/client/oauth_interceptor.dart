import 'package:dio/dio.dart';
import 'package:features_common_data/interfaces/oauth_local_repository.dart';
import 'package:features_common_data/interfaces/oauth_token_refresher.dart';

class OauthInterceptor extends Interceptor {
  OauthInterceptor(this._tokensProvider, this._tokenRefresher);

  static int unauthorizedCode = 401;

  final OAuthLocalRepository _tokensProvider;
  final OAuthTokenRefresher _tokenRefresher;

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
      handler.reject(DioException(error: unauthorizedCode, requestOptions: err.requestOptions));
    } else {
      handler.reject(err);
    }
  }
}
