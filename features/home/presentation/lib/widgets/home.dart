import 'package:features_reddit_posts_presentation/navigation/navigator.dart' as reddit_posts;
import 'package:features_weather_presentation/navigation/navigator.dart' as weather;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late reddit_posts.PostsNavigator redditPostsNavigator = Modular.get();
  late weather.WeatherNavigator weatherNavigator = Modular.get();

  late final _widgetOptions = [
    redditPostsNavigator.homePage(),
    weatherNavigator.homePage(),
  ];

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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
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
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
