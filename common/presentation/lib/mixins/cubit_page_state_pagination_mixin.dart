import 'package:common_presentation/widgets/page_state/cubit_page_state_mixin.dart';

import 'cubit_pagination_mixin.dart';

mixin CubitPageStatePaginationMixin<T> on CubitPageStateMixin<DataWithPagination<T>> {
  DataWithPagination<T>? get dataWithPagination => stateData;

  emitDataWithPagination(DataWithPagination<T>? dataWithPagination) => emitData(dataWithPagination);
}

mixin CubitPageStatePaginationIterableMixin<T> on CubitPageStateMixin<DataWithPagination<Iterable<T>>> {
  Iterable<T> addPages(Iterable<T> nextPageData) => [
        ...stateData?.data ?? [],
        ...nextPageData,
      ];

  bool get isCanLoadPages => stateData?.data.isNotEmpty == true;

  bool isLastPage(Iterable<T> data) => data.isEmpty;
}
