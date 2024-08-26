import 'package:common_data/interfaces/oauth_tokens_entity.dart';
import 'package:dio/dio.dart';

import 'content_type_interceptor.dart';
import 'oauth_interceptor.dart';

Dio _createOauthClient<T extends OauthTokensEntity>(
  OauthInterceptor<T> oauthInterceptor,
  ContentTypeInterceptor contentTypeInterceptor,
) {
  var dio = Dio();
  dio.interceptors.add(oauthInterceptor);
  dio.interceptors.add(contentTypeInterceptor);
  return dio;
}
