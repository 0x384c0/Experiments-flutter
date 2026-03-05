import 'package:features_weather_presentation/src/widgets/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// Navigation for weather feature
@Deprecated('use auto_route directly')
abstract class WeatherNavigator {
  Widget home();
}

/// Private implementation if weather navigation
@Injectable(as: WeatherNavigator)
class NavigatorImpl implements WeatherNavigator {
  @override
  home() => const WeatherScreen();
}
