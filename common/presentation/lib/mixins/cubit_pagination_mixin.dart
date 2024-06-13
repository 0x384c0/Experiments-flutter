mixin CubitPaginationMixin<D, T extends DataWithPagination<D>> {
  //region abstract
  bool get isCanLoadPages;

  bool isLastPage(D data);

  Future<D> loadPage(int pageNumber);

  /// Add new data from page to existing state and return this new state
  D addPages(D nextPageData);

  T? get dataWithPagination;

  emitDataWithPagination(T? dataWithPagination);

  //endregion

  //region implemented
  PaginationState get _paginationState => dataWithPagination?.paginationState ?? PaginationState.empty();

  /// Resets state of pages
  void onBeforeFirstPageLoad() {
    final paginationState = _paginationState.copyWith(currentPageIndex: 0, isFinalPageLoaded: false);
    final oldData = dataWithPagination;
    if (oldData != null) {
      final data = oldData.copyWith(paginationState: paginationState);
      emitDataWithPagination(data as T);
    } else {
      emitDataWithPagination(null);
    }
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
      ) as T);
      final result = await loadPage(_paginationState.currentPageIndex);
      if (isLastPage(result)) {
        emitDataWithPagination(
            dataWithPagination?.copyWith(paginationState: _paginationState.copyWith(isFinalPageLoaded: true)) as T);
      } else {
        emitDataWithPagination(dataWithPagination?.copyWith(data: addPages(result)) as T);
      }
    } catch (e) {
      emitDataWithPagination(
          dataWithPagination?.copyWith(paginationState: _paginationState.copyWith(isFinalPageLoaded: true)) as T);
      rethrow;
    } finally {
      await Future.delayed(const Duration(milliseconds: 50));
      emitDataWithPagination(
          dataWithPagination?.copyWith(paginationState: _paginationState.copyWith(isLoadingPage: false)) as T);
    }
  }
//endregion
}

abstract interface class DataWithPagination<T> {
  T get data;

  PaginationState? get paginationState;

  DataWithPagination<T> copyWith({
    T? data,
    PaginationState? paginationState,
  });
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
