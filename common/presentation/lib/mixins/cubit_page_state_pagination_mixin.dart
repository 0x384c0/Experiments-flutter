import 'package:common_presentation/widgets/page_state/cubit_page_state_mixin.dart';

import 'cubit_pagination_mixin.dart';

mixin CubitPageStatePaginationMixin<D,T extends StateWithPagination<D>> on CubitPageStateMixin<T> {
  T? get dataWithPagination => stateData;

  emitDataWithPagination(T? dataWithPagination) => emitData(dataWithPagination);
}

mixin CubitPageStatePaginationIterableMixin<D,T extends StateWithPagination<Iterable<D>>> on CubitPageStateMixin<T> {
  Iterable<D> addPages(Iterable<D> nextPageData) => [
        ...stateData?.data ?? [],
        ...nextPageData,
      ];

  bool get isCanLoadPages => stateData?.data.isNotEmpty == true;

  bool isLastPage(Iterable<D> data) => data.isEmpty;
}
