import 'package:common_presentation/widgets/page_state/page_state.dart';
import 'package:common_presentation/widgets/page_state/bloc_page_state_mixin.dart';
import 'package:common_presentation/widgets/empty_view.dart';
import 'package:common_presentation/widgets/error_view.dart';
import 'package:common_presentation/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// View for single page, that show automatically [LoadingIndicator], [EmptyStateView] or child [Widget] depending of [PageState] type from state
class PageStateView<B extends BlocBase<PageState<T>>, T> extends StatelessWidget {
  const PageStateView({
    super.key,
    required this.refresh,
    required this.child,
  });

  /// convenience initializer for passing [BlocPageStateMixin] only
  static bloc<B extends BlocPageStateMixin<T>, T>({
    Key? key,
    required B Function() getBloc,
    required Widget Function(T data) child,
  }) =>
      PageStateView<B, T>(
        key: key,
        refresh: ({bool? showLoading}) async => await getBloc().refresh(showLoading: showLoading),
        child: child,
      );

  final Future<void> Function({bool? showLoading}) refresh;
  final Widget Function(T data) child;

  @override
  Widget build(BuildContext context) => BlocBuilder<B, PageState<T>>(
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
