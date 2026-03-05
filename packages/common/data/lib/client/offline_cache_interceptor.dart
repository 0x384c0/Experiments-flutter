import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/dio.dart';

/// for requests with [offlineCacheExtraKey] in [extra] will return cached data if server unavailable
class OfflineCacheInterceptor extends DioCacheInterceptor implements OfflineCacheRepository {
  final CacheStore _cacheStore;

  OfflineCacheInterceptor(this._cacheStore)
    : super(
        options: CacheOptions(
          store: _cacheStore,
          maxStale: const Duration(hours: 1),
          // hitCacheOnNetworkFailure: true,
          policy: CachePolicy.forceCache,
        ),
      );

  static const _offlineCacheExtraKey = 'offlineCacheExtraKey';

  bool _isShouldCache(Map<String, dynamic>? extra) => extra?.containsKey(_offlineCacheExtraKey) == true;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_isShouldCache(options.extra)) {
      super.onRequest(options, handler);
    } else {
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_isShouldCache(response.requestOptions.extra)) {
      super.onResponse(response, handler);
    } else {
      handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_isShouldCache(err.requestOptions.extra)) {
      super.onError(err, handler);
    } else {
      handler.next(err);
    }
  }

  @override
  Future clean() async {
    try {
      _cacheStore.clean();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

/// Retrofit requests marked with @OfflineCached() will be cached with [OfflineCacheInterceptor]
class OfflineCached extends TypedExtras {
  final String offlineCacheExtraKey;

  const OfflineCached({this.offlineCacheExtraKey = ''});
}

abstract interface class OfflineCacheRepository {
  Future clean();
}
