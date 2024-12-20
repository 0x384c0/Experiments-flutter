import 'package:common_data/interfaces/oauth_local_repository.dart';
import 'package:common_data/interfaces/oauth_token_refresher.dart';
import 'package:common_data/interfaces/oauth_tokens_entity.dart';
import 'package:common_domain/data/error_model.dart';
import 'package:dio/dio.dart';

class OauthInterceptor<T extends OauthTokensEntity> extends Interceptor {
  OauthInterceptor(this._tokensProvider, this._tokenRefresher);

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
    if (err.response?.statusCode == ErrorModel.unauthorizedCode) {
      handler.next(DioException(
        error: ErrorModel(type: ErrorModelType.badResponse, code: err.response?.statusCode),
        requestOptions: err.requestOptions,
      ));
    } else {
      handler.next(err);
    }
  }
}
