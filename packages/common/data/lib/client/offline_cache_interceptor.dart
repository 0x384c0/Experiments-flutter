import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/cupertino.dart';

/// for requests with [offlineCacheExtraKey] in [extra] will return cached data if server unavailable
class OfflineCacheInterceptor extends Interceptor {
  OfflineCacheInterceptor(
    CacheStore store,
  ) : _cacheOptions = CacheOptions(
          store: store,
          maxStale: const Duration(days: 7),
        );

  static const offlineCacheExtraKey = 'offlineCacheExtraKey';

  final CacheOptions _cacheOptions;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_shouldSkip(options)) {
      handler.next(options);
      return;
    }
    options.extra[CacheResponse.requestSentDate] = DateTime.now();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final requestOptions = response.requestOptions;
    if (!_shouldSkip(requestOptions)) await _saveResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldSkip(err.requestOptions, error: err)) {
      handler.next(err);
      return;
    }

    final cacheResponse = await _loadResponse(err.requestOptions);
    if (cacheResponse != null) {
      handler.resolve(cacheResponse);
      return;
    }

    handler.next(err);
  }

  bool _shouldSkip(
    RequestOptions? request, {
    DioException? error,
  }) {
    if (error?.type == DioExceptionType.cancel) {
      return true;
    }
    if (error != null && _isNotSocketException(error)) return true;
    final shouldCache = request?.extra.containsKey(offlineCacheExtraKey) == true;
    return !shouldCache;
  }

  bool _isNotSocketException(DioException error) =>
      error.type == DioExceptionType.connectionError && error.error is! SocketException;

  Future _saveResponse(Response response) async {
    try {
      final request = response.requestOptions;
      final cacheResponse = await CacheResponse.fromResponse(
        key: _cacheOptions.keyBuilder(request),
        options: _cacheOptions,
        response: response,
      );
      await _getCacheStore(_cacheOptions).set(await cacheResponse.writeContent(
        _cacheOptions,
        response: response,
      ));
    } catch (e) {
      debugPrint(e.toString());
      await clean();
    }
  }

  Future<Response?> _loadResponse(RequestOptions request) async {
    try {
      final existing = await _loadCacheResponse(request);
      return existing?.toResponse(request);
    } catch (e) {
      debugPrint(e.toString());
      await clean();
      return null;
    }
  }

  Future<CacheResponse?> _loadCacheResponse(RequestOptions request) async {
    final options = _getCacheOptions(request);
    final cacheKey = options.keyBuilder(request);
    final cacheStore = _getCacheStore(options);
    final response = await cacheStore.get(cacheKey);

    if (response != null) {
      // Purge entry if staled
      final maxStale = CacheOptions.fromExtra(request)?.maxStale;
      if ((maxStale == null || maxStale == const Duration(microseconds: 0)) && response.isStaled()) {
        await cacheStore.delete(cacheKey);
        return null;
      }

      return response.readContent(options);
    }

    return null;
  }

  CacheStore _getCacheStore(CacheOptions options) => options.store!;

  CacheOptions _getCacheOptions(RequestOptions request) {
    return CacheOptions.fromExtra(request) ?? _cacheOptions;
  }

  Future clean() async {
    try {
      _cacheOptions.store?.clean();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

// /// Retrofit requests marked with @OfflineCached() will be cached with [OfflineCacheInterceptor]
// class OfflineCached extends TypedExtras {
//   final String offlineCacheExtraKey;
//
//   const OfflineCached({this.offlineCacheExtraKey = ''});
// }
