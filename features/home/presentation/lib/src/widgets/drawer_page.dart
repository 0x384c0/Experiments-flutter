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
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Other experiments'),
          ),
          ListTile(
            title: const Text('WebView'),
            onTap: kIsWeb ? null : () => _onDestinationSelected(context, SelectedPage.webView),
            tileColor:
                selectedScreen == SelectedPage.webView ? Theme.of(context).colorScheme.surfaceContainerHighest : null,
          ).opacity(opacity: kIsWeb ? 0.5 : 1),
        ],
      );

  _onDestinationSelected(BuildContext context, SelectedPage screen) {
    Navigator.pop(context);
    onDestinationSelected(SelectedPage.webView);
  }
}
