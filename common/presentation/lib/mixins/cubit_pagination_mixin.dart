mixin CubitPaginationMixin<T> {
  //region abstract
  bool get isCanLoadPages;

  bool isLastPage(T data);

  Future<T> loadPage(int pageNumber);

  /// Add new data from page to existing state and return this new state
  T addPages(T nextPageData);

  DataWithPagination<T>? get dataWithPagination;

  emitDataWithPagination(DataWithPagination<T>? dataWithPagination);

  //endregion

  //region implemented
  PaginationState get _paginationState => dataWithPagination?.paginationState ?? PaginationState.empty();

  DataWithPagination<T> newPaginationState(T data) => DataWithPagination(data: data);

  /// Resets state of pages
  void onBeforeFirstPageLoad() {
    emitDataWithPagination(dataWithPagination?.copyWith(
        paginationState: _paginationState.copyWith(
      currentPageIndex: 0,
      isFinalPageLoaded: false,
    )));
  }

  /// Call this method, when view is scrolled to end
  Future<void> loadNextPage() async {
    if (_paginationState.isLoadingPage || _paginationState.isFinalPageLoaded) return;
    try {
      emitDataWithPagination(dataWithPagination?.copyWith(
        paginationState: _paginationState.copyWith(
          isLoadingPage: true,
          currentPageIndex: _paginationState.currentPageIndex + 1,
        ),
      ));
      final result = await loadPage(_paginationState.currentPageIndex);
      if (isLastPage(result)) {
        emitDataWithPagination(
            dataWithPagination?.copyWith(paginationState: _paginationState.copyWith(isFinalPageLoaded: true)));
      } else {
        emitDataWithPagination(dataWithPagination?.copyWith(data: addPages(result)));
      }
    } catch (e) {
      emitDataWithPagination(
          dataWithPagination?.copyWith(paginationState: _paginationState.copyWith(isFinalPageLoaded: true)));
      rethrow;
    } finally {
      await Future.delayed(const Duration(milliseconds: 50));
      emitDataWithPagination(
          dataWithPagination?.copyWith(paginationState: _paginationState.copyWith(isLoadingPage: false)));
    }
  }
//endregion
}

class DataWithPagination<T> {
  final T data;
  final PaginationState? paginationState;

  DataWithPagination({required this.data, this.paginationState});

  DataWithPagination<T> copyWith({
    T? data,
    PaginationState? paginationState,
  }) =>
      DataWithPagination(
        data: data ?? this.data,
        paginationState: paginationState ?? this.paginationState,
      );
}

class PaginationState {
  PaginationState({
    required this.currentPageIndex,
    required this.isLoadingPage,
    required this.isFinalPageLoaded,
  });

  final int currentPageIndex;
  final bool isLoadingPage;
  final bool isFinalPageLoaded;

  factory PaginationState.empty() => PaginationState(
        currentPageIndex: 0,
        isLoadingPage: false,
        isFinalPageLoaded: false,
      );

  PaginationState copyWith({
    int? currentPageIndex,
    bool? isLoadingPage,
    bool? isFinalPageLoaded,
  }) =>
      PaginationState(
        currentPageIndex: currentPageIndex ?? this.currentPageIndex,
        isLoadingPage: isLoadingPage ?? this.isLoadingPage,
        isFinalPageLoaded: isFinalPageLoaded ?? this.isFinalPageLoaded,
      );
}
