import 'package:common_presentation/widgets/page_state/bloc_screen_state_mixin.dart';

import 'cubit_pagination_mixin.dart';

mixin CubitPageStatePaginationMixin<D, T extends StateWithPagination<D>> on BlocScreenStateMixin<T> {
  T? get dataWithPagination => stateData;

  emitDataWithPagination(T? dataWithPagination) => emitData(dataWithPagination);
}

mixin CubitPageStatePaginationIterableMixin<D,T> on BlocScreenStateMixin<T> {
  Iterable<D>? addPages(Iterable<D> nextPageData) => getPagesIterable()?.followedBy(nextPageData);

  bool get isCanLoadPages => getPagesIterable()?.isNotEmpty == true;

  bool isLastPage(Iterable<D> data) => data.isEmpty;

  Iterable<D>? getPagesIterable();
}
