import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen_state.dart';

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

  emitError(String errorDescription) {
    if (!isClosed) {
      final data = stateData;
      if (data != null) {
        emit(ScreenStatePopulatedError(data: data, errorDescription: errorDescription));
      } else {
        emit(ScreenStateEmptyError(errorDescription: errorDescription));
      }
    }
  }

  emitLoading() {
    if (!isClosed) {
      final data = stateData;
      if (data != null) {
        emit(ScreenStatePopulatedLoading(data: data));
      } else {
        emit(ScreenStateEmptyLoading());
      }
    }
  }

  ScreenState<T> _getNewStateFromData({T? data}) {
    if (data == null) return ScreenStateEmptyLoading<T>();
    if (data is List && data.isEmpty) return ScreenStateEmpty<T>();
    return ScreenStatePopulated<T>(data: data);
  }

  /// override to intercept errors
  /// For example logout on Unauthorized errors
  Future<bool> interceptError(Object e) async => false;

  /// Should be called after creation of [Bloc] or manually to reload all data
  @nonVirtual
  Future refresh({bool? showLoading}) async {
    try {
      if (showLoading == true) emitLoading();
      await onRefresh();
    } catch (e) {
      if (!(await interceptError(e))) {
        emitError(e.toString());
      }
    }
  }

  /// Will be called after calling [refresh]
  Future onRefresh() async {}
}
