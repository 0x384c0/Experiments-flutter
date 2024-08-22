import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:common_presentation/widgets/page_state/bloc_page_state_mixin.dart';
import 'package:common_presentation/widgets/empty_view.dart';
import 'package:common_presentation/widgets/error_view.dart';
import 'package:common_presentation/widgets/loading_indicator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// View for single page, that show automatically [LoadingIndicator], [EmptyStateView] or child [Widget] depending of [PageState] type from state
Widget createPageStateBlocBuilder<B extends BlocBase<PageState<T>>, T>({
  Key? key,
  Widget Function(T? data, Widget child) layoutBuilder = _defaultLayoutBuilder,
  required Future<void> Function({bool? showLoading}) refresh,
  required Widget Function(T data) child,
}) =>
    BlocBuilder<B, PageState<T>>(
      builder: (context, state) {
        late Widget widget;
        T? data;
        switch (state) {
          case final PageStateEmptyError state:
            widget = ErrorView(
              errorDescription: state.errorDescription,
              refresh: () => refresh(showLoading: true),
            );
            break;
          case final PageStateEmptyLoading _:
            widget = const LoadingIndicator();
            break;
          case final PageStatePopulated<T> state:
            data = state.data;
            widget = child(state.data);
            break;
          case final PageStateEmpty _:
            widget = EmptyStateView(refresh: refresh);
            break;
          default:
            widget = EmptyStateView(refresh: refresh);
        }
        return layoutBuilder(data, widget);
      },
    );

Widget _defaultLayoutBuilder(_, child) => child;

/// convenience method for passing [BlocPageStateMixin] only
Widget createBlocPageStateBlocBuilder<B extends BlocPageStateMixin<T>, T>({
  Key? key,
  Widget Function(T? data, Widget child) layoutBuilder = _defaultLayoutBuilder,
  required B Function() getBloc,
  required Widget Function(T data) child,
}) =>
    createPageStateBlocBuilder<B, T>(
      key: key,
      layoutBuilder: layoutBuilder,
      refresh: ({bool? showLoading}) async => await getBloc().refresh(showLoading: showLoading),
      child: child,
    );
