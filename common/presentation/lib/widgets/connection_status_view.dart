import 'dart:async';

import 'package:common_presentation/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionStatusView extends StatefulWidget {
  const ConnectionStatusView({
    super.key,
    this.safeAreaTop = false,
    this.safeAreaBottom = true,
    this.onConnectionStatusChanged,
  });

  final bool safeAreaTop;
  final bool safeAreaBottom;
  final Function(bool isConnected)? onConnectionStatusChanged;

  @override
  State<StatefulWidget> createState() => _ConnectionStatusViewState();

  static withChild(Widget child, {
    ThemeData? theme,
    AlignmentDirectional alignment = AlignmentDirectional.bottomCenter,
    Function(bool isConnected)? onConnectionStatusChanged,
  }) {
    Widget result = Stack(
      alignment: alignment,
      children: [
        child,
        ConnectionStatusView(
          safeAreaTop: alignment != AlignmentDirectional.bottomCenter,
          safeAreaBottom: alignment == AlignmentDirectional.bottomCenter,
          onConnectionStatusChanged: onConnectionStatusChanged,
        )
      ],
    );
    if (theme != null) result = Theme(data: theme, child: Material(child: result));
    return result;
  }
}

class _ConnectionStatusViewState extends State<ConnectionStatusView> {
  final _animationDuration = const Duration(milliseconds: 400);
  final _hideDuration = const Duration(seconds: 2);

  var _state = _ConnectionStatusState.hidden;
  Timer? _hideTimer;
  late final StreamSubscription<InternetConnectionStatus> _subscription;
  static const _opacity = 0.8;

  @override
  Widget build(BuildContext context) =>
      AnimatedSwitcher(
        duration: _animationDuration,
        layoutBuilder: _defaultLayoutBuilder,
        child: body(),
      );

  Widget _defaultLayoutBuilder(Widget? currentChild, List<Widget> previousChildren) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ...previousChildren,
        if (currentChild != null) currentChild,
      ].map((e) => SizedBox(width: double.infinity, child: e)).toList(),
    );
  }

  Widget body() {
    final commonLocale = context.commonLocalization!;
    switch (_state) {
      case _ConnectionStatusState.hidden:
        return const SizedBox.shrink();
      case _ConnectionStatusState.noConnection:
        return DecoratedBox(
          key: const ValueKey(_ConnectionStatusState.noConnection),
          decoration: BoxDecoration(color: context.theme.colorScheme.error.withOpacity(_opacity)),
          child: SafeArea(
            top: widget.safeAreaTop,
            bottom: widget.safeAreaBottom,
            child: Text(
              commonLocale.common_no_connection,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.bodySmall?.copyWith(color: context.theme.colorScheme.onError),
            ),
          ),
        );
      case _ConnectionStatusState.backOnline:
        return DecoratedBox(
          key: const ValueKey(_ConnectionStatusState.backOnline),
          decoration: BoxDecoration(color: context.theme.colorScheme.tertiary.withOpacity(_opacity)),
          child: SafeArea(
            top: widget.safeAreaTop,
            bottom: widget.safeAreaBottom,
            child: Text(
              commonLocale.common_back_online,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.bodySmall?.copyWith(color: context.theme.colorScheme.onTertiary),
            ),
          ),
        );
    }
  }

  @override
  void initState() {
    _subscription = InternetConnectionChecker().onStatusChange.listen((status) =>
        setState(() {
          widget.onConnectionStatusChanged?.call(status == InternetConnectionStatus.connected);
          switch (_state) {
            case _ConnectionStatusState.hidden:
            case _ConnectionStatusState.backOnline:
              if (status == InternetConnectionStatus.disconnected) _state = _ConnectionStatusState.noConnection;
              _cancelHide();
              break;
            case _ConnectionStatusState.noConnection:
              if (status == InternetConnectionStatus.connected) _state = _ConnectionStatusState.backOnline;
              _hideDelayed();
              break;
          }
        }));
    super.initState();
  }

  _cancelHide() => _hideTimer?.cancel();

  _hideDelayed() {
    _cancelHide();
    _hideTimer = Timer(
      _hideDuration,
          () =>
          setState(() {
            _state = _ConnectionStatusState.hidden;
          }),
    );
  }

  @override
  void dispose() {
    _cancelHide();
    _subscription.cancel();
    super.dispose();
  }
}

enum _ConnectionStatusState {
  hidden,
  noConnection,
  backOnline,
}
