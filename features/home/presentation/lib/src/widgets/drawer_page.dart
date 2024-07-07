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
          ).opacity(kIsWeb ? 0.5 : 1),
        ],
      );

  _onDestinationSelected(BuildContext context, SelectedPage screen) {
    Navigator.pop(context);
    onDestinationSelected(SelectedPage.webView);
  }
}
