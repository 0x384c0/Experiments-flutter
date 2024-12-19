import 'package:flutter/material.dart';

import '../widgets/on_app_event_builder.dart';
import '../widgets/on_locale_change_builder.dart';

extension WidgetListener on Widget {
  /// [child] will be recreated when one of [events] triggered by [AppStateNotifier] and on locale change if [localeChange] is true
  Widget wrapInEventListeners({
    bool localeChange = true,
    List<AppEvent> events = const [
      AppEvent.invalidateAll,
    ],
    required Widget child,
  }) {
    var result = child;
    if (localeChange) {
      result = OnLocaleChangeBuilder(child: result);
    }
    if (events.isNotEmpty) {
      result = OnAppEventBuilder(events: events, child: result);
    }
    return result;
  }
}
