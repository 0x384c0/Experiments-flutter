import 'package:features_reddit_posts_presentation/navigation/reddit_posts_navigator.dart';
import 'package:features_reddit_posts_presentation/widgets/posts_view.dart';
import 'package:features_weather_presentation/navigation/weather_navigator.dart';
import 'package:features_weather_presentation/widgets/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    PostsPage(), //TODO: use navigator instead of views
    WeatherPage(),
    Text(
      'Index 2: Others',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late WeatherNavigator weatherNavigator = Modular.get();
  late RedditPostsNavigator redditPostsNavigator = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // body: const RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Reddit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Others',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        // onTap: (index) {
        //   switch (index) {
        //     case 0:
        //       redditPostsNavigator.home();
        //       break;
        //     case 1:
        //       weatherNavigator.home();
        //       break;
        //     case 2:
        //       redditPostsNavigator.home();
        //       break;
        //   }
        //   _selectedIndex = index;
        // },
      ),
    );
  }
}
