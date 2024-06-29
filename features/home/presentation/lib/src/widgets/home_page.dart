import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_home_presentation/src/widgets/drawer_page.dart';
import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';
import 'package:features_weather_presentation/features_weather_presentation.dart';
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

  late final _widgetOptions = [
    redditPostsNavigator.homePage(),
    weatherNavigator.homePage(),
    formsNavigator.homePage(),
  ];

  Widget _getWidgetOptionTitle(BuildContext context, index) => [
        Text(AppLocalizations.of(context)!.reddit_posts_home_page),
        Text(AppLocalizations.of(context)!.weather_home_page),
        Text(AppLocalizations.of(context)!.forms_home_page),
      ][index];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: _getWidgetOptionTitle(context, _selectedIndex)),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      drawer: Drawer(child: DrawerPage()),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.web),
            label: locale.reddit_posts_home_page,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.cloud),
            label: locale.weather_home_page,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.edit_note),
            label: locale.forms_home_page,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
