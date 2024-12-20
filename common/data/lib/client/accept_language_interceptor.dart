import 'dart:io';

import 'package:dio/dio.dart';

class AcceptLanguageInterceptor extends Interceptor {
  AcceptLanguageInterceptor(this._localeRepository);

  final LocaleRepository _localeRepository;

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final headers = _localeRepository.headers;

    headers.forEach((key, value) {
      if (!options.headers.containsKey(key)) {
        options.headers[key] = value;
      }
    });

    if (!options.headers.containsKey(HttpHeaders.acceptHeader)) {
      options.headers[HttpHeaders.acceptHeader] = 'application/json';
    }

    handler.next(options);
  }
}

abstract interface class LocaleRepository {
  Map<String, String> get headers;
}
