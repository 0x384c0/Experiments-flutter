import 'package:common_presentation/widgets/screen_state/screen_state.dart';
import 'package:common_presentation/widgets/screen_state/bloc_screen_state_mixin.dart';
import 'package:common_presentation/widgets/empty_state_view.dart';
import 'package:common_presentation/widgets/error_view.dart';
import 'package:common_presentation/widgets/loading_indicator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// View for single page, that show automatically [LoadingIndicator], [EmptyStateView] or child [Widget] depending of [ScreenState] type from state
Widget createScreenStateBlocBuilder<B extends BlocBase<ScreenState<T>>, T>({
  Key? key,
  Widget Function(T? data, Widget child) layoutBuilder = _defaultLayoutBuilder,
  required Future<void> Function({bool? showLoading}) refresh,
  required Widget Function(T data) child,
}) =>
    BlocBuilder<B, ScreenState<T>>(
      builder: (context, state) {
        late Widget widget;
        T? data;
        switch (state) {
          case final ScreenStateEmptyError state:
            widget = ErrorView(
              errorDescription: state.errorDescription,
              refresh: () => refresh(showLoading: true),
            );
            break;
          case final ScreenStateEmptyLoading _:
            widget = const LoadingIndicator();
            break;
          case final ScreenStatePopulated<T> state:
            data = state.data;
            widget = child(state.data);
            break;
          case final ScreenStateEmpty _:
            widget = EmptyStateView(refresh: refresh);
            break;
          default:
            widget = EmptyStateView(refresh: refresh);
        }
        return layoutBuilder(data, widget);
      },
    );

Widget _defaultLayoutBuilder(_, child) => child;

/// convenience method for passing [BlocScreenStateMixin] only
Widget createBlocScreenStateBlocBuilder<B extends BlocScreenStateMixin<T>, T>({
  Key? key,
  Widget Function(T? data, Widget child) layoutBuilder = _defaultLayoutBuilder,
  required B Function() getBloc,
  required Widget Function(T data) child,
}) =>
    createScreenStateBlocBuilder<B, T>(
      key: key,
      layoutBuilder: layoutBuilder,
      refresh: ({bool? showLoading}) async => await getBloc().refresh(showLoading: showLoading),
      child: child,
    );
