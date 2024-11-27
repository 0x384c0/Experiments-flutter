import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../empty_state_view.dart';
import '../error_view.dart';
import '../loading_indicator.dart';
import '../loading_overlay_view.dart';
import 'bloc_screen_state_mixin.dart';
import 'screen_state.dart';

/// View for single screen, that show automatically [LoadingIndicator], [EmptyStateView] or child [Widget] depending of [ScreenState] type from state
Widget _createScreenStateBlocBuilder<B extends BlocBase<ScreenState<T>>, T>({
  Key? key,
  Widget Function(T? data, Widget child) layoutBuilder = _defaultLayoutBuilder,
  required Future<void> Function({bool? showLoading})? refresh,
  required Widget Function(T data) builder,
  required bool isSliver,
  required ScreenState<T> state,
  required BuildContext context,
  Widget? loadingView,
  Widget? emptyView,
}) {
  late Widget widget;
  T? data;
  switch (state) {
    case final ScreenStateEmptyError state:
      widget = ErrorView(
        errorDescription: state.errorDescription,
        refresh: refresh != null ? () => refresh(showLoading: true) : null,
      );
      break;
    case final ScreenStateEmptyLoading _:
      widget = loadingView ?? const LoadingIndicator();
      break;
    case final ScreenStatePopulatedError<T> state:
      data = state.data;
      widget = LoadingOverlayView(isLoading: false, child: builder(state.data));
      _showSnackBar(context, state.errorDescription);
      break;
    case final ScreenStatePopulatedLoading<T> state:
      data = state.data;
      widget = LoadingOverlayView(isLoading: true, child: builder(state.data));
      break;
    case final ScreenStatePopulated<T> state:
      data = state.data;
      widget = LoadingOverlayView(isLoading: false, child: builder(state.data)); //TODO: use ZStack instead of providing child to LoadingOverlayView
      break;
    case final ScreenStateEmpty _:
      widget = emptyView ?? EmptyStateView(refresh: refresh);  //TODO: use builders instead of using views like this directly
      break;
    default:
      widget = emptyView ?? EmptyStateView(refresh: refresh);
  }

  if (isSliver && state is! ScreenStatePopulated<T>) {
    widget = SliverToBoxAdapter(child: SizedBox(height: 400, child: widget));
  }
  return layoutBuilder(data, widget);
}

_showSnackBar(BuildContext context, String message) => WidgetsBinding.instance.addPostFrameCallback((_) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(SnackBar(content: Text(message)));
});

Widget _defaultLayoutBuilder(_, child) => child;

/// convenience method for passing [BlocScreenStateMixin] only
Widget _createBlocScreenStateBlocBuilder<B extends BlocScreenStateMixin<T>, T>({
  Key? key,
  Widget Function(T? data, Widget child) layoutBuilder = _defaultLayoutBuilder,
  required Future<void> Function({bool? showLoading})? refresh,
  required Widget Function(T data) builder,
  required bool isSliver,
  required ScreenState<T> state,
  Widget? loadingView,
  Widget? emptyView,
  required BuildContext context,
}) =>
    _createScreenStateBlocBuilder<B, T>(
      key: key,
      layoutBuilder: layoutBuilder,
      refresh: refresh,
      builder: builder,
      isSliver: isSliver,
      state: state,
      loadingView: loadingView,
      emptyView: emptyView,
      context: context,
    );

/// [BlocBuilder] for single screen, that automatically show [LoadingIndicator], [EmptyStateView] or child [Widget] depending of [ScreenState]
// TODO: try to separate logic of loading indicators, empty states, etc. from its screen business logic as two separate Blocs
class ScreenStateBlocBuilder<B extends BlocScreenStateMixin<S>, S> extends BlocBuilder<B, ScreenState<S>> {
  ScreenStateBlocBuilder({
    super.key,
    bool isSliver = false,
    bool isCanRefreshSelf = true,
    Widget Function(S? data, Widget child) layoutBuilder = _defaultLayoutBuilder,
    required Widget Function(BuildContext context, S data) builder,
    Widget? loadingView,
    Widget? emptyView,
  }) : super(
    builder: (context, state) => _createBlocScreenStateBlocBuilder<B, S>(
      refresh: isCanRefreshSelf
          ? ({bool? showLoading}) async => await context.read<B>().refresh(showLoading: showLoading)
          : null,
      layoutBuilder: _defaultLayoutBuilder,
      builder: (data) => builder(context, data),
      isSliver: isSliver,
      context: context,
      state: state,
      loadingView: loadingView,
      emptyView: emptyView,
    ),
  );
}
