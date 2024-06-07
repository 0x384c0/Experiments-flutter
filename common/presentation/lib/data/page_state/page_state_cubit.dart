import 'package:common_presentation/data/page_state/page_state.dart';
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

  Future<bool> _interceptError(Object e) async {
    // final shouldLogout = await userAuth.shouldLogoutOnError(e); //TODO: inject auth error intercept logic
    // if (shouldLogout) launcherNavigator.toEntryPoint();
    // return shouldLogout;
    return false;
  }

  // AuthInteractor get userAuth;
  //
  // LauncherNavigator get launcherNavigator;

  /// Should be called after creation of [PageStateView]
  @nonVirtual
  Future refresh() async {
    try {
      await onRefresh();
    } catch (e) {
      if (!(await _interceptError(e))) {
        emitEmptyError(e.toString());
      }
    }
  }

  /// Will be called after creation of [PageStateView]
  Future onRefresh();
}
