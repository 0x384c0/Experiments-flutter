import 'package:common_presentation/mixins/cubit_alert_mixin.dart';
import 'package:common_presentation/mixins/cubit_pagination_mixin.dart';
import 'package:common_presentation/widgets/alert_dialog.dart';

class GenericPageState<T> implements DataWithPagination<T>, DataWithAlert {
  GenericPageState({
    required this.data,
    this.paginationState,
    this.alertDialogState,
  });

  @override
  final T data;

  @override
  final PaginationState? paginationState;

  @override
  final AlertDialogState? alertDialogState;

  @override
  GenericPageState<T> copyWith({
    T? data,
    PaginationState? paginationState,
    AlertDialogState? alertDialogState,
  }) {
    return GenericPageState(
      data: data ?? this.data,
      paginationState: paginationState ?? this.paginationState,
      alertDialogState: alertDialogState ?? this.alertDialogState,
    );
  }
}
