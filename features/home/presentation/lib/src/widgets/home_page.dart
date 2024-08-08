import 'package:features_experiments_presentation/features_experiments_presentation.dart';
import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_home_presentation/src/widgets/drawer_page.dart';
import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';
import 'package:features_weather_presentation/features_weather_presentation.dart';
import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PostsNavigator redditPostsNavigator = Modular.get();
  late WeatherNavigator weatherNavigator = Modular.get();
  late FormsNavigator formsNavigator = Modular.get();
  late WebViewNavigator webViewNavigator = Modular.get();
  late ExperimentsNavigator experimentsNavigator = Modular.get();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final destinations = [
      NavigationDestination(
        icon: const Icon(Icons.edit_note),
        label: locale.forms_home_page,
      ),
      NavigationDestination(
        icon: const Icon(Icons.web),
        label: locale.reddit_posts_home_page,
      ),
      NavigationDestination(
        icon: const Icon(Icons.cloud),
        label: locale.weather_home_page,
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: _getPageTitle(context, _selectedScreen)),
      body: _body(context),
      drawer: Drawer(
        child: DrawerPage(
          selectedScreen: _selectedScreen,
          onDestinationSelected: (e) => _onDestinationSelected(e.id),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: destinations,
        selectedIndex: _selectedScreen.id.clamp(0, destinations.length - 1),
        onDestinationSelected: _onDestinationSelected,
        indicatorColor: destinations.length <= _selectedScreen.id ? Colors.transparent : null,
      ),
    );
  }

  SelectedPage _selectedScreen = SelectedPage.defaultPage;
  final _pageController = PageController(initialPage: SelectedPage.defaultPage.id);
  final _bucket = PageStorageBucket();

  Widget _getPageTitle(BuildContext context, SelectedPage index) => {
        SelectedPage.posts: Text(AppLocalizations.of(context)!.reddit_posts_home_page),
        SelectedPage.weather: Text(AppLocalizations.of(context)!.weather_home_page),
        SelectedPage.forms: Text(AppLocalizations.of(context)!.forms_home_page),
        SelectedPage.webView: Text(AppLocalizations.of(context)!.webview_home_page),
        SelectedPage.experiments: Text(AppLocalizations.of(context)!.experiments_home_page),
      }[index]!;

  late final _pages = [
    formsNavigator.homePage(),
    redditPostsNavigator.homePage(),
    weatherNavigator.homePage(),
    webViewNavigator.homePage(),
    experimentsNavigator.homePage(),
  ];

  Widget _body(BuildContext context) {
    return PageStorage(
      bucket: _bucket,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }

  _onDestinationSelected(int selectedIndex) {
    setState(() {
      _selectedScreen = SelectedPage.values.firstWhere((e) => e.id == selectedIndex);
      _pageController.jumpToPage(selectedIndex);
    });
  }
}

enum SelectedPage {
  forms(0),
  posts(1),
  weather(2),
  webView(3),
  experiments(4);

  const SelectedPage(this.id);

  final int id;

  static SelectedPage defaultPage = SelectedPage.forms;
}
