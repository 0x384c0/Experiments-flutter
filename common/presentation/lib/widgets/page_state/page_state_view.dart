import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:common_presentation/widgets/page_state/cubit_page_state_mixin.dart';
import 'package:common_presentation/widgets/empty_view.dart';
import 'package:common_presentation/widgets/error_view.dart';
import 'package:common_presentation/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';

/// View for single page, that show automatically [LoadingIndicator], [EmptyStateView] or child [Widget] depending of [PageState] type from state
class PageStateView<T> extends StatelessWidget {
  const PageStateView({
    super.key,
    required this.state,
    required this.refresh,
    required this.child,
  });

  /// convenience initializer for passing [CubitPageStateMixin] only
  PageStateView.cubut({super.key, required CubitPageStateMixin<T> cubit, required this.child})
      : state = cubit.state,
        refresh = cubit.refresh;

  final PageState<T> state;
  final Future<void> Function({bool? showLoading}) refresh;
  final Widget Function(T data) child;

  @override
  Widget build(BuildContext context) {
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
  }
}
