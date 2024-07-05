import 'package:common_presentation/extensions/flutterui_modifiers.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class DrawerPage extends StatelessWidget {
  const DrawerPage({
    super.key,
    required this.selectedScreen,
    required this.onDestinationSelected,
  });

  final SelectedScreen selectedScreen;
  final Function(SelectedScreen) onDestinationSelected;

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
            onTap: kIsWeb ? null : () => _onDestinationSelected(context, SelectedScreen.webView),
            tileColor:
                selectedScreen == SelectedScreen.webView ? Theme.of(context).colorScheme.surfaceContainerHighest : null,
          ).opacity(kIsWeb ? 0.5 : 1),
        ],
      );

  _onDestinationSelected(BuildContext context, SelectedScreen screen) {
    Navigator.pop(context);
    onDestinationSelected(SelectedScreen.webView);
  }
}
