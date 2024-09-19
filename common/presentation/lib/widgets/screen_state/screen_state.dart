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
