import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [Bloc], that can emit [PageState]
mixin BlocPageStateMixin<T> on BlocBase<PageState<T>> {
  /// Returns data if type [T] if loaded, null otherwise
  T? get stateData {
    if (state is PageStatePopulated<T>) {
      return (state as PageStatePopulated<T>).data;
    } else {
      return null;
    }
  }

  /// Emit new state
  emitData(T? data) {
    if (!isClosed) emit(_getNewStateFromData(data: data));
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

  PageState<T> _getNewStateFromData({T? data}) {
    if (data == null) return PageStateEmptyLoading<T>();
    if (data is List && data.isEmpty) return PageStateEmpty<T>();
    return PageStatePopulated<T>(data: data);
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
