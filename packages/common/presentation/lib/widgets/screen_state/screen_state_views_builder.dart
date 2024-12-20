import 'package:flutter/material.dart';

import '../empty_state_view.dart';
import '../error_view.dart';
import '../loading_indicator.dart';

class ScreenStateViewBuilder {
  final Widget Function(BuildContext, String)? errorViewBuilder;
  final Widget Function(BuildContext)? loadingViewBuilder;
  final Widget Function(BuildContext, Widget)? populatedViewBuilder;
  final Widget Function(BuildContext, Future Function({bool? showLoading})? refresh)? emptyViewBuilder;

  const ScreenStateViewBuilder({
    this.errorViewBuilder,
    this.loadingViewBuilder,
    this.populatedViewBuilder,
    this.emptyViewBuilder,
  });

  Widget buildErrorView(
    BuildContext context,
    String errorDescription,
    Future Function({bool? showLoading})? refresh,
  ) =>
      errorViewBuilder?.call(context, errorDescription) ??
      ErrorView(
        errorDescription: errorDescription,
        refresh: refresh != null ? () => refresh(showLoading: true) : null,
      );

  Widget buildLoadingView(BuildContext context) => loadingViewBuilder?.call(context) ?? const LoadingIndicator();

  Widget buildPopulatedView(
    BuildContext context,
    Widget body,
  ) =>
      populatedViewBuilder?.call(context, body) ?? body;

  Widget buildEmptyView(
    BuildContext context,
    Future Function({bool? showLoading})? refresh,
  ) =>
      emptyViewBuilder?.call(context, refresh) ?? EmptyStateView(refresh: refresh);

  showAlert(
    BuildContext context,
    String message,
  ) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.clearSnackBars();
        messenger.showSnackBar(SnackBar(content: Text(message)));
      });
}
