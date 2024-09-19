import 'package:common_presentation/widgets/screen_state/screen_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [Bloc], that can emit [ScreenState]
mixin BlocScreenStateMixin<T> on BlocBase<ScreenState<T>> {
  /// Returns data if type [T] if loaded, null otherwise
  T? get stateData {
    if (state is ScreenStatePopulated<T>) {
      return (state as ScreenStatePopulated<T>).data;
    } else {
      return null;
    }
  }

  /// Emit new state
  emitData(T? data) {
    if (!isClosed) emit(_getNewStateFromData(data: data));
  }

  emitEmpty() {
    if (!isClosed) emit(ScreenStateEmpty());
  }

  emitEmptyError(String errorDescription) {
    if (!isClosed) emit(ScreenStateEmptyError(errorDescription: errorDescription));
  }

  emitEmptyLoading() {
    if (!isClosed) emit(ScreenStateEmptyLoading());
  }

  ScreenState<T> _getNewStateFromData({T? data}) {
    if (data == null) return ScreenStateEmptyLoading<T>();
    if (data is List && data.isEmpty) return ScreenStateEmpty<T>();
    return ScreenStatePopulated<T>(data: data);
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
