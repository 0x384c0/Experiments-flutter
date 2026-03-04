import '../widgets/weather_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@Deprecated('use auto_route directly')
/// Navigation for weather feature
abstract class WeatherNavigator {
  Widget home();
}

/// Private implementation if weather navigation
class NavigatorImpl implements WeatherNavigator {
  @override
  home() => const WeatherScreen();
}
