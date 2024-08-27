import 'package:common_domain/data/error_model.dart';

extension MapErrorFuture<T> on Future<T> {
  Future<T> mapError<E extends Object>(E Function(dynamic error) mapError) =>
      then<T>((value) => value, onError: (error) => throw mapError(error));
}

extension NetworkCacheFuture<T> on Future<T> {
  Future<T> cached({
    required Future Function(T) saveToCache,
    required Future<T?> Function() getFromCache,
    required Future<bool> Function()? shouldInvalidateCache,
    required Future Function()? invalidateCache,
  }) {
    assert((shouldInvalidateCache == null) == (invalidateCache == null));
    return then(
      (data) async {
        if (await shouldInvalidateCache?.call() ?? false) await invalidateCache?.call();
        await saveToCache(data);
        return data;
      },
    ).onError<ErrorModel>(
      (e, _) async {
        final result = await getFromCache();
        if (result == null) throw e;
        return result;
      },
      test: (e) => e.type == ErrorModelType.connectionError,
    );
  }
}
