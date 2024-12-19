import 'package:flutter/material.dart';
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
    Widget Function(T? data, Widget child) layoutBuilder = _defaultLayoutBuilder,
    required Future<void> Function({bool? showLoading})? refresh,
    required Widget Function(T data) builder,
    required bool isSliver,
    required ScreenState<T> state,
    required BuildContext context,
    required ScreenStateViewBuilder viewsBuilder,
  }) {
    late Widget widget;
    T? data;
    switch (state) {
      case final ScreenStateEmptyError state:
        widget = viewsBuilder.buildErrorView(context, state.errorDescription, refresh);
        break;
      case final ScreenStateEmptyLoading _:
        widget = viewsBuilder.buildLoadingView(context);
        break;
      case final ScreenStatePopulatedError<T> state:
        data = state.data;
        widget = viewsBuilder.buildPopulatedView(context, builder(state.data));
        viewsBuilder.showAlert(context, state.errorDescription);
        break;
      case final ScreenStatePopulatedLoading<T> state:
        data = state.data;
        widget = viewsBuilder.buildPopulatedLoadingView(context, builder(state.data));
        break;
      case final ScreenStatePopulated<T> state:
        data = state.data;
        widget = viewsBuilder.buildPopulatedView(context, builder(state.data));
        break;
      case final ScreenStateEmpty _:
        widget = viewsBuilder.buildEmptyView(context, refresh);
        break;
      default:
        widget = viewsBuilder.buildEmptyView(context, refresh);
    }

    if (isSliver && state is! ScreenStatePopulated<T>) {
      widget = SliverToBoxAdapter(child: SizedBox(height: 400, child: widget));
    }
    return layoutBuilder(data, widget);
  }

  static Widget _defaultLayoutBuilder(_, child) => child;

  /// convenience method for passing [BlocScreenStateMixin] only
  static Widget _createBlocScreenStateBlocBuilder<B extends BlocScreenStateMixin<T>, T>({
    Key? key,
    Widget Function(T? data, Widget child) layoutBuilder = _defaultLayoutBuilder,
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
        isSliver: isSliver,
        state: state,
        context: context,
        viewsBuilder: viewsBuilder,
      );
}
