import 'package:flutter/material.dart';

import '../../data/selected_page_state.dart';

class HomePagesProvider extends InheritedWidget {
  final Function(SelectedPageState selectedIndex) onDestinationSelected;

  const HomePagesProvider({
    required this.onDestinationSelected,
    required super.child,
    super.key,
  });

  static HomePagesProvider? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<HomePagesProvider>();

  @override
  bool updateShouldNotify(HomePagesProvider oldWidget) => onDestinationSelected != oldWidget.onDestinationSelected;
}
