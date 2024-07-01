import 'package:flutter/material.dart';

import 'home_page.dart';

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
            onTap: () => _onDestinationSelected(context, SelectedScreen.webView),
            tileColor: selectedScreen == SelectedScreen.webView ? Theme.of(context).colorScheme.surfaceContainerHighest : null,
          ),
        ],
      );

  _onDestinationSelected(BuildContext context, SelectedScreen screen) {
    Navigator.pop(context);
    onDestinationSelected(SelectedScreen.webView);
  }
}
