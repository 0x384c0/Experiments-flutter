import 'package:features_experiments_presentation/features_experiments_presentation.dart';
import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_home_presentation/l10n/app_localizations.g.dart' as home_localizations;
import 'package:features_home_presentation/src/screens/drawer_screen.dart';
import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';
import 'package:features_stackoverflow_presentation/features_stackoverflow_presentation.dart';
import 'package:features_weather_presentation/features_weather_presentation.dart';
import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/selected_page_state.dart';
import 'others_screen.dart';
import 'widgets/home_pages_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostsNavigator redditPostsNavigator = Modular.get();
  late WeatherNavigator weatherNavigator = Modular.get();
  late FormsNavigator formsNavigator = Modular.get();
  late WebViewNavigator webViewNavigator = Modular.get();
  late ExperimentsNavigator experimentsNavigator = Modular.get();
  late StackOverflowNavigator stackoverflowNavigator = Modular.get();

  @override
  Widget build(BuildContext context) {
    final locale = _getLocalization(context);
    final destinations = [
      NavigationDestination(
        icon: const Icon(Icons.edit_note),
        label: locale.home_forms,
      ),
      NavigationDestination(
        icon: const Icon(Icons.web),
        label: locale.home_posts,
      ),
      NavigationDestination(
        icon: const Icon(Icons.cloud),
        label: locale.home_weather,
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: _getPageTitle(context, _selectedScreen)),
      body: _body(context),
      drawer: Drawer(
        child: DrawerScreen(
          selectedScreen: _selectedScreen,
          onDestinationSelected: (e) => _onDestinationSelected(e),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: destinations,
        selectedIndex: _selectedScreen.id.clamp(0, destinations.length - 1),
        onDestinationSelected: _onDestinationSelectedIndex,
        indicatorColor: destinations.length <= _selectedScreen.id ? Colors.transparent : null,
      ),
    );
  }

  SelectedPageState _selectedScreen = SelectedPageState.defaultPage;
  final _pageController = PageController(initialPage: SelectedPageState.defaultPage.id);
  final _bucket = PageStorageBucket();

  Widget _getPageTitle(BuildContext context, SelectedPageState index) => {
        SelectedPageState.posts: Text(_getLocalization(context).home_posts),
        SelectedPageState.weather: Text(_getLocalization(context).home_weather),
        SelectedPageState.forms: Text(_getLocalization(context).home_forms),
        SelectedPageState.webView: Text(_getLocalization(context).home_webview),
        SelectedPageState.experiments: Text(_getLocalization(context).home_experiments),
        SelectedPageState.stackoverflow: Text(_getLocalization(context).home_stackoverflow),
        SelectedPageState.others: Text(_getLocalization(context).home_others),
      }[index]!;

  late final _pages = [
    formsNavigator.home(),
    redditPostsNavigator.home(),
    weatherNavigator.home(),
    webViewNavigator.home(),
    experimentsNavigator.home(),
    stackoverflowNavigator.home(),
    const OthersScreen(),
  ];

  Widget _body(BuildContext context) {
    return PageStorage(
      bucket: _bucket,
      child: HomePagesProvider(
        onDestinationSelected: _onDestinationSelected,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
      ),
    );
  }

  _onDestinationSelected(SelectedPageState selection) => _onDestinationSelectedIndex(selection.id);

  _onDestinationSelectedIndex(int selectedIndex) {
    setState(() {
      _selectedScreen = SelectedPageState.values.firstWhere((e) => e.id == selectedIndex);
      _pageController.jumpToPage(selectedIndex);
    });
  }

  home_localizations.AppLocalizations _getLocalization(BuildContext context) =>
      home_localizations.AppLocalizations.of(context)!;
}
