import 'dart:async';
import 'package:dio/dio.dart';

/// A Dio interceptor that ensures requests are not sent
/// more often than once every [delay] duration.
/// Default: 200ms
class RateLimitInterceptor extends Interceptor {
  final Duration delay;

  DateTime _lastRequestTime = DateTime.fromMillisecondsSinceEpoch(0);
  Completer<void>? _lock;

  RateLimitInterceptor({this.delay = const Duration(milliseconds: 200)});

  Future<void> _waitForTurn() async {
    final now = DateTime.now();
    final diff = now.difference(_lastRequestTime);

    if (diff < delay) {
      // Too soon, wait for remaining time
      await Future.delayed(delay - diff);
    }

    _lastRequestTime = DateTime.now();
  }

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Chain requests so only one is processed at a time
    while (_lock != null) {
      await _lock!.future;
    }

    _lock = Completer<void>();

    try {
      await _waitForTurn();
      handler.next(options);
    } finally {
      _lock?.complete();
      _lock = null;
    }
  }
}