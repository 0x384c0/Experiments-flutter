import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:common_presentation/widgets/alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// TODO: try to implements as mixin instead of class
/// Cubit, that can emit [PageState]
abstract class PageStateCubit<T> extends Cubit<PageState<T>> {
  PageStateCubit({PageState<T>? initialState}) : super(initialState ?? PageStateEmptyLoading());

  /// Will close alert, caused by [alertDialogState]
  closeAlert() {
    emit(state.copyWith(alertDialogState: StateWithAlert.noAlert));
  }

  emitAlert({required AlertDialogState alertDialogState}) {
    emit(state.copyWith(alertDialogState: alertDialogState));
  }

  /// Returns data if type [T] if loaded, null otherwise
  T? get stateData => state is PageStatePopulated<T> ? (state as PageStatePopulated<T>).data : null;

  /// Emit new state
  emitData(T? data) {
    if (!isClosed) emit(state.newWith(data: data));
  }

  emitEmpty() {
    if (!isClosed) emit(PageStateEmpty());
  }

  emitEmptyError(String errorDescription) {
    if (!isClosed) emit(PageStateEmptyError(errorDescription: errorDescription));
  }

  emitEmptyLoading() {
    if (!isClosed) emit(PageStateEmptyLoading());
  }

  /// override to intercept errors
  /// For example logout on Unauthorized errors
  Future<bool> interceptError(Object e) async => false;

  /// Should be called after creation of [PageStateView]
  @nonVirtual
  Future refresh({bool? showLoading}) async {
    try {
      if (showLoading == true) emitEmptyLoading();
      await onRefresh();
    } catch (e) {
      if (!(await interceptError(e))) {
        emitEmptyError(e.toString());
      }
    }
  }

  /// Will be called after creation of [PageStateView]
  Future onRefresh();
}
