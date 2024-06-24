import 'package:common_presentation/widgets/page_state/bloc_page_state_mixin.dart';

import 'cubit_pagination_mixin.dart';

mixin CubitPageStatePaginationMixin<D, T extends StateWithPagination<D>> on BlocPageStateMixin<T> {
  T? get dataWithPagination => stateData;

  emitDataWithPagination(T? dataWithPagination) => emitData(dataWithPagination);
}

mixin CubitPageStatePaginationIterableMixin<D, T extends StateWithPagination<Iterable<D>>> on BlocPageStateMixin<T> {
  Iterable<D>? addPages(Iterable<D> nextPageData) => stateData?.data.followedBy(nextPageData);

  bool get isCanLoadPages => stateData?.data.isNotEmpty == true;

  bool isLastPage(Iterable<D> data) => data.isEmpty;
}
