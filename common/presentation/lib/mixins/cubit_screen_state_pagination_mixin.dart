import 'package:common_presentation/widgets/screen_state/bloc_screen_state_mixin.dart';

import 'cubit_pagination_mixin.dart';

mixin CubitScreenStatePaginationMixin<D, T extends StateWithPagination<D>> on BlocScreenStateMixin<T> {
  T? get dataWithPagination => stateData;

  emitDataWithPagination(T? dataWithPagination) => emitData(dataWithPagination);
}

mixin CubitScreenStatePaginationIterableMixin<D,T> on BlocScreenStateMixin<T> {
  Iterable<D>? addPages(Iterable<D> nextPageData) => getPagesIterable()?.followedBy(nextPageData);

  bool get isCanLoadPages => getPagesIterable()?.isNotEmpty == true;

  bool isLastPage(Iterable<D> data) => data.isEmpty;

  Iterable<D>? getPagesIterable();
}
