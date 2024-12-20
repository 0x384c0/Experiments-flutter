import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnAppEventBuilder extends StatefulWidget {
  final Widget child;
  final List<AppEvent> events;

  const OnAppEventBuilder({
    super.key,
    required this.child,
    required this.events,
  });

  @override
  State<StatefulWidget> createState() => _OnAppEventBuilderState();
}

class _OnAppEventBuilderState extends State<OnAppEventBuilder> {
  var _childKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final appStateNotifier = context.watch<AppStateNotifier>();
    if (widget.events.contains(appStateNotifier.lastEvent)) _childKey = UniqueKey();
    return KeyedSubtree(
      key: _childKey,
      child: widget.child,
    );
  }
}

class AppStateNotifier extends ChangeNotifier {
  AppEvent? _lastEvent;

  AppEvent? get lastEvent => _lastEvent;

  void triggerEvent(AppEvent event) {
    _lastEvent = event;
    notifyListeners();
  }
}

enum AppEvent {
  invalidateAll,
}
