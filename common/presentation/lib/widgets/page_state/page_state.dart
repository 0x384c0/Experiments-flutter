import 'package:common_presentation/mixins/cubit_pagination_mixin.dart';
import 'package:common_presentation/widgets/alert_dialog.dart';

/// Statef of page that has state for data and alert
// TODO: make PageState abstract
abstract class PageState<T> implements StateWithPagination {
  PageState({
    this.alertDialogState,
    this.paginationState,
  });

  final AlertDialogState? alertDialogState;

  @override
  final PaginationState? paginationState;

  PageState<T> newWith({T? data}) {
    if (data == null) return PageStateEmptyLoading<T>();
    if (data is List && data.isEmpty) return PageStateEmpty<T>();
    return PageStatePopulated<T>(data: data);
  }

  @override
  PageState<T> copyWith({
    T? data,
    AlertDialogState? alertDialogState,
    PaginationState? paginationState,
  });
}

class PageStateEmpty<T> extends PageState<T> {
  PageStateEmpty({
    AlertDialogState? alertDialogState,
    PaginationState? paginationState,
  }) : super(
          alertDialogState: alertDialogState,
          paginationState: paginationState,
        );

  @override
  PageState<T> copyWith({
    T? data,
    AlertDialogState? alertDialogState,
    PaginationState? paginationState,
  }) =>
      PageStateEmpty(
        alertDialogState: alertDialogState ?? this.alertDialogState,
        paginationState: paginationState ?? this.paginationState,
      );
}

class PageStateEmptyLoading<T> extends PageState<T> {
  PageStateEmptyLoading({
    AlertDialogState? alertDialogState,
    PaginationState? paginationState,
  }) : super(
          alertDialogState: alertDialogState,
          paginationState: paginationState,
        );

  @override
  PageState<T> copyWith({
    T? data,
    AlertDialogState? alertDialogState,
    PaginationState? paginationState,
  }) =>
      PageStateEmptyLoading(
        alertDialogState: alertDialogState ?? this.alertDialogState,
        paginationState: paginationState ?? this.paginationState,
      );
}

class PageStateEmptyError<T> extends PageState<T> {
  PageStateEmptyError({
    AlertDialogState? alertDialogState,
    PaginationState? paginationState,
    required this.errorDescription,
  }) : super(
          alertDialogState: alertDialogState,
          paginationState: paginationState,
        );

  final String errorDescription;

  @override
  PageState<T> copyWith({
    T? data,
    AlertDialogState? alertDialogState,
    PaginationState? paginationState,
  }) =>
      PageStateEmptyError(
        alertDialogState: alertDialogState ?? this.alertDialogState,
        paginationState: paginationState ?? this.paginationState,
        errorDescription: errorDescription,
      );
}

class PageStatePopulated<T> extends PageState<T> {
  PageStatePopulated({
    required this.data,
    AlertDialogState? alertDialogState,
    PaginationState? paginationState,
  }) : super(
          alertDialogState: alertDialogState,
          paginationState: paginationState,
        );

  T data;

  @override
  PageState<T> copyWith({
    T? data,
    AlertDialogState? alertDialogState,
    PaginationState? paginationState,
  }) =>
      PageStatePopulated<T>(
        alertDialogState: alertDialogState ?? this.alertDialogState,
        paginationState: paginationState ?? this.paginationState,
        data: data ?? this.data,
      );
}
