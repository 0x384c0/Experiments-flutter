import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:common_presentation/widgets/alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit, that can emit [PageState]
mixin CubitPageStateMixin<T> on Cubit<PageState<T>> {

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
