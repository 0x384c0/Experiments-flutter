import 'package:auto_route/auto_route.dart';
import 'package:features_home_presentation/features_home_presentation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_view_modifiers/flutter_view_modifiers.dart';

import '../data/selected_page_state.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    final homeChildren = getHomeChildren();
    final homeChildrenMap = homeChildren.map((info) => info.selectedPageState).toList().asMap();
    final state = homeChildrenMap[tabsRouter.activeIndex];

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: Colors.blue),
          child: Text(_getLocalizations(context).home_other_experiments),
        ),
        ListTile(
          title: Text(_getLocalizations(context).home_webview),
          onTap: kIsWeb ? null : () => _onDestinationSelected(context, tabsRouter, SelectedPageState.webView),
          tileColor: state == SelectedPageState.webView ? Theme.of(context).colorScheme.surfaceContainerHighest : null,
        ).withOpacity(kIsWeb ? 0.5 : 1),
        ListTile(
          title: Text(_getLocalizations(context).home_experiments),
          onTap: () => _onDestinationSelected(context, tabsRouter, SelectedPageState.experiments),
          tileColor: state == SelectedPageState.experiments
              ? Theme.of(context).colorScheme.surfaceContainerHighest
              : null,
        ),
        ListTile(
          title: Text(_getLocalizations(context).home_stackoverflow),
          onTap: () => _onDestinationSelected(context, tabsRouter, SelectedPageState.stackoverflow),
          tileColor: state == SelectedPageState.stackoverflow
              ? Theme.of(context).colorScheme.surfaceContainerHighest
              : null,
        ),
        ListTile(
          title: Text(_getLocalizations(context).home_others),
          onTap: () => _onDestinationSelected(context, tabsRouter, SelectedPageState.others),
          tileColor: state == SelectedPageState.others ? Theme.of(context).colorScheme.surfaceContainerHighest : null,
        ),
      ],
    );
  }

  void _onDestinationSelected(BuildContext context, TabsRouter tabsRouter, SelectedPageState screen) {
    Navigator.pop(context); // close drawer
    final homeChildren = getHomeChildren();
    final screenIndex = homeChildren.indexWhere((info) => info.selectedPageState == screen);
    tabsRouter.setActiveIndex(screenIndex);
  }

  AppLocalizations _getLocalizations(BuildContext context) => AppLocalizations.of(context)!;
}
