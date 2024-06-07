import 'package:flutter_bloc/flutter_bloc.dart';

mixin CubitPaginationMixin<S extends StateWithPagination, D> on Cubit<S> {
  //region overrides
  bool get isCanLoadPages;

  bool isLastPage(D data);

  Future<D> loadPage(int pageNumber);

  /// Here add new data from page to existing state and emit it
  emitWithNewPage(D nextPageData);

  //endregion

  //region internal
  PaginationState get _paginationState => state.paginationState ?? PaginationState.empty();

  /// Resets state of pages
  void onBeforeFirstPageLoad() {
    emit(state.copyWith(
        paginationState: _paginationState.copyWith(
      currentPageIndex: 0,
      isFinalPageLoaded: false,
    )) as S);
  }

  /// Call this method, when view is scrolled to end
  Future<void> loadNextPage() async {
    if (_paginationState.isLoadingPage || _paginationState.isFinalPageLoaded) return;
    try {
      emit(state.copyWith(
        paginationState: _paginationState.copyWith(
          isLoadingPage: true,
          currentPageIndex: _paginationState.currentPageIndex + 1,
        ),
      ) as S);
      final result = await loadPage(_paginationState.currentPageIndex);
      if (isLastPage(result)) {
        emit(state.copyWith(paginationState: _paginationState.copyWith(isFinalPageLoaded: true)) as S);
      } else {
        emitWithNewPage(result);
      }
    } catch (e) {
      emit(state.copyWith(paginationState: _paginationState.copyWith(isFinalPageLoaded: true)) as S);
      rethrow;
    } finally {
      await Future.delayed(const Duration(milliseconds: 50));
      emit(state.copyWith(paginationState: _paginationState.copyWith(isLoadingPage: false)) as S);
    }
  }
//endregion
}

abstract class StateWithPagination {
  abstract final PaginationState? paginationState;

  StateWithPagination copyWith({PaginationState? paginationState});
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
