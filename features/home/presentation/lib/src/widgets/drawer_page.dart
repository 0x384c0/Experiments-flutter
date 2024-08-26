import 'package:features_home_presentation/l10n/app_localizations.g.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:widgets_modifiers/painting/painting_effect_widgets_modifiers.dart';

import 'home_page.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({
    super.key,
    required this.selectedScreen,
    required this.onDestinationSelected,
  });

  final SelectedPage selectedScreen;
  final Function(SelectedPage) onDestinationSelected;

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Text(_getLocalizations(context).home_other_experiments),
          ),
          ListTile(
            title: Text(_getLocalizations(context).home_webview),
            onTap: kIsWeb ? null : () => _onDestinationSelected(context, SelectedPage.webView),
            tileColor:
                selectedScreen == SelectedPage.webView ? Theme.of(context).colorScheme.surfaceContainerHighest : null,
          ).opacity(opacity: kIsWeb ? 0.5 : 1),
          ListTile(
            title: Text(_getLocalizations(context).home_experiments),
            onTap: () => _onDestinationSelected(context, SelectedPage.experiments),
          ),
          ListTile(
            title: Text(_getLocalizations(context).home_stackoverflow),
            onTap: () => _onDestinationSelected(context, SelectedPage.stackoverflow),
          ),
        ],
      );

  _onDestinationSelected(BuildContext context, SelectedPage screen) {
    Navigator.pop(context);
    onDestinationSelected(screen);
  }

  AppLocalizations _getLocalizations(BuildContext context) => AppLocalizations.of(context)!;
}
