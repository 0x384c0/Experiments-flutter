import 'package:auto_route/auto_route.dart';
import 'package:features_home_presentation/features_home_presentation.dart';
import 'package:features_home_presentation/l10n/app_localizations.g.dart' as home_localizations;
import 'package:features_home_presentation/src/data/selected_page_state.dart';
import 'package:features_home_presentation/src/screens/drawer_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeChildren = getHomeChildren();
    final homeChildrenMap = homeChildren.map((info) => info.selectedPageState).toList().asMap();
    return AutoTabsScaffold(
      routes: homeChildren.map((info) => info.getRouteInfo()).toList(),
      appBarBuilder: (context, tabsRouter) {
        final index = tabsRouter.activeIndex;
        final selectedPageState = homeChildrenMap[index];
        return AppBar(title: _getPageTitle(context, selectedPageState));
      },
      drawer: const Drawer(child: DrawerScreen()),
      bottomNavigationBuilder: (context, tabsRouter) {
        final locale = _getLocalization(context);
        final destinations = {
          SelectedPageState.forms: NavigationDestination(icon: const Icon(Icons.edit_note), label: locale.home_forms),
          SelectedPageState.posts: NavigationDestination(icon: const Icon(Icons.web), label: locale.home_posts),
          SelectedPageState.weather: NavigationDestination(icon: const Icon(Icons.cloud), label: locale.home_weather),
        };
        final destinationStates = destinations.keys.toList();
        final activeState = homeChildrenMap[tabsRouter.activeIndex];
        final selectedIndex = activeState != null ? destinationStates.indexOf(activeState) : -1;
        return NavigationBar(
          destinations: destinations.values.toList(),
          selectedIndex: selectedIndex >= 0 ? selectedIndex : 0,
          onDestinationSelected: (index) {
            final state = destinationStates[index];
            final tabIndex = homeChildren.indexWhere((info) => info.selectedPageState == state);
            if (tabIndex != -1) {
              tabsRouter.setActiveIndex(tabIndex);
            }
          },
          indicatorColor: selectedIndex == -1 ? Colors.transparent : null,
        );
      },
    );
  }

  Widget _getPageTitle(BuildContext context, SelectedPageState? state) {
    try {
      final localization = _getLocalization(context);
      final string = {
        SelectedPageState.posts: localization.home_posts,
        SelectedPageState.weather: localization.home_weather,
        SelectedPageState.forms: localization.home_forms,
        SelectedPageState.webView: localization.home_webview,
        SelectedPageState.experiments: localization.home_experiments,
        SelectedPageState.stackoverflow: localization.home_stackoverflow,
        SelectedPageState.others: localization.home_others,
      }[state!]!;
      return Text(string);
    } catch (e) {
      return SizedBox.shrink();
    }
  }

  home_localizations.AppLocalizations _getLocalization(BuildContext context) =>
      home_localizations.AppLocalizations.of(context)!;
}
