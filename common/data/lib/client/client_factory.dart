import 'package:dio/dio.dart';

import 'content_type_interceptor.dart';
import 'oauth_interceptor.dart';

Dio _createOauthClient(
  OauthInterceptor oauthInterceptor,
  ContentTypeInterceptor contentTypeInterceptor,
) {
  var dio = Dio();
  dio.interceptors.add(oauthInterceptor);
  dio.interceptors.add(contentTypeInterceptor);
  return dio;
}
