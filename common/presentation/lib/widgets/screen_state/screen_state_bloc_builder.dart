import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_screen_state_mixin.dart';
import 'screen_state.dart';
import 'screen_state_views_builder.dart';

/// [BlocBuilder] for single screen, that automatically show [LoadingIndicator], [EmptyStateView] or child [Widget] depending of [ScreenState]
class ScreenStateBlocBuilder<B extends BlocScreenStateMixin<S>, S> extends BlocBuilder<B, ScreenState<S>> {
  final ScreenStateViewBuilder viewsBuilder;

  ScreenStateBlocBuilder({
    super.key,
    bool isSliver = false,
    bool isCanRefreshSelf = true,
    this.viewsBuilder = const ScreenStateViewBuilder(),
    Widget Function(S? data, Widget child) layoutBuilder = _defaultLayoutBuilder,
    required Widget Function(BuildContext context, S data) builder,
  }) : super(
          builder: (context, state) => _createBlocScreenStateBlocBuilder<B, S>(
            refresh: isCanRefreshSelf
                ? ({bool? showLoading}) async => await context.read<B>().refresh(showLoading: showLoading)
                : null,
            layoutBuilder: layoutBuilder,
            builder: (data) => builder(context, data),
            isSliver: isSliver,
            context: context,
            state: state,
            viewsBuilder: viewsBuilder,
          ),
        );

  static Widget _createScreenStateBlocBuilder<B extends BlocBase<ScreenState<T>>, T>({
    Key? key,
    required Widget Function(T? data, Widget child) layoutBuilder,
    required Future<void> Function({bool? showLoading})? refresh,
    required Widget Function(T data) builder,
    required ScreenState<T> state,
    required BuildContext context,
    required ScreenStateViewBuilder viewsBuilder,
  }) {
    Widget? body;
    Widget? overlay;
    T? data;
    switch (state) {
      case final ScreenStateEmptyError state:
        overlay = viewsBuilder.buildErrorView(context, state.errorDescription, refresh);
        break;
      case final ScreenStateEmptyLoading _:
        overlay = viewsBuilder.buildLoadingView(context);
        break;
      case final ScreenStateEmpty _:
        overlay = viewsBuilder.buildEmptyView(context, refresh);
        break;
      case final ScreenStatePopulatedError<T> state:
        data = state.data;
        body = viewsBuilder.buildPopulatedView(context, builder(state.data));
        viewsBuilder.showAlert(context, state.errorDescription);
        break;
      case final ScreenStatePopulatedLoading<T> state:
        data = state.data;
        body = viewsBuilder.buildPopulatedView(context, builder(state.data));
        overlay = viewsBuilder.buildLoadingView(context);
        break;
      case final ScreenStatePopulated<T> state:
        data = state.data;
        body = viewsBuilder.buildPopulatedView(context, builder(state.data));
        break;
    }

    assert(overlay != null || body != null);

    Widget widget = Stack(children: [
      overlay ?? const SizedBox.shrink(),
      body ?? const SizedBox.shrink(),
    ]);

    return layoutBuilder(data, widget);
  }

  /// convenience method for passing [BlocScreenStateMixin] only
  static Widget _createBlocScreenStateBlocBuilder<B extends BlocScreenStateMixin<T>, T>({
    Key? key,
    required Widget Function(T? data, Widget child) layoutBuilder,
    required Future<void> Function({bool? showLoading})? refresh,
    required Widget Function(T data) builder,
    required bool isSliver,
    required ScreenState<T> state,
    required BuildContext context,
    required ScreenStateViewBuilder viewsBuilder,
  }) =>
      _createScreenStateBlocBuilder<B, T>(
        key: key,
        layoutBuilder: layoutBuilder,
        refresh: refresh,
        builder: builder,
        state: state,
        context: context,
        viewsBuilder: viewsBuilder,
      );

  static Widget _defaultLayoutBuilder(_, child) => child;

  static Widget sliverLayoutBuilder(_, child) => SliverToBoxAdapter(child: SizedBox(height: 400, child: child));
}
