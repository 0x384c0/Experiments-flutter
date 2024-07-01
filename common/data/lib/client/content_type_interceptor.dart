import 'dart:io';

import 'package:dio/dio.dart';

class ContentTypeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      if (!options.headers.containsKey(HttpHeaders.contentTypeHeader))
        HttpHeaders.contentTypeHeader: 'application/json',
      if (!options.headers.containsKey(HttpHeaders.acceptHeader)) HttpHeaders.acceptHeader: 'application/json',
    });
    handler.next(options);
  }
}
