abstract interface class ScreenState<T> {}

final class ScreenStateEmpty<T> extends ScreenState<T> {}

final class ScreenStateEmptyLoading<T> extends ScreenState<T> {}

final class ScreenStateEmptyError<T> extends ScreenState<T> {
  ScreenStateEmptyError({required this.errorDescription});

  final String errorDescription;
}

final class ScreenStatePopulated<T> extends ScreenState<T> {
  ScreenStatePopulated({required this.data});

  T data;
}

final class ScreenStatePopulatedLoading<T> extends ScreenStatePopulated<T> {
  ScreenStatePopulatedLoading({required super.data});
}

final class ScreenStatePopulatedError<T> extends ScreenStatePopulated<T> {
  ScreenStatePopulatedError({
    required super.data,
    required this.errorDescription,
  });

  final String errorDescription;
}
