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
  required Future<void> Function({bool? showLoading}) refresh,
  required Widget Function(T data) child,
}) {
  return BlocBuilder<B, PageState<T>>(
    builder: (context, state) {
      switch (state) {
        case final PageStateEmptyError state:
          return ErrorView(
            errorDescription: state.errorDescription,
            refresh: () => refresh(showLoading: true),
          );
        case final PageStateEmptyLoading _:
          return const LoadingIndicator();
        case final PageStatePopulated<T> state:
          return child(state.data);
        case final PageStateEmpty _:
          return EmptyStateView(refresh: refresh);
        default:
          return EmptyStateView(refresh: refresh);
      }
    },
  );
}

/// convenience method for passing [BlocPageStateMixin] only
Widget createBlocPageStateBlocBuilder<B extends BlocPageStateMixin<T>, T>({
  Key? key,
  required B Function() getBloc,
  required Widget Function(T data) child,
}) =>
    createPageStateBlocBuilder<B, T>(
      key: key,
      refresh: ({bool? showLoading}) async => await getBloc().refresh(showLoading: showLoading),
      child: child,
    );
