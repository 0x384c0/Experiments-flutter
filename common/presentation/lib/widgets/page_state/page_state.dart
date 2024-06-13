abstract interface class PageState<T> {}

final class PageStateEmpty<T> extends PageState<T> {}

final class PageStateEmptyLoading<T> extends PageState<T> {}

final class PageStateEmptyError<T> extends PageState<T> {
  PageStateEmptyError({required this.errorDescription});

  final String errorDescription;
}

final class PageStatePopulated<T> extends PageState<T> {
  PageStatePopulated({required this.data});

  T data;
}
