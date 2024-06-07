extension MapErrorFuture<T> on Future<T> {
  Future<T> mapError<E extends Object>(E Function(dynamic error) mapError) =>
      then<T>((value) => value, onError: (error) => throw mapError(error));
}
