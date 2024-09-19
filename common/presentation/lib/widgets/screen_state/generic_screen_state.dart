import 'package:common_presentation/mixins/cubit_alert_mixin.dart';
import 'package:common_presentation/mixins/cubit_pagination_mixin.dart';
import 'package:common_presentation/widgets/alert_dialog.dart';

class GenericScreenState<T> implements StateWithPagination<T>, StateWithAlert {
  GenericScreenState({
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
  GenericScreenState<T> copyWith({
    T? data,
    PaginationState? paginationState,
    AlertDialogState? alertDialogState,
  }) {
    return GenericScreenState(
      data: data ?? this.data,
      paginationState: paginationState ?? this.paginationState,
      alertDialogState: alertDialogState ?? this.alertDialogState,
    );
  }
}
