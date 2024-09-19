import '../data/weather_state.dart';
import '../widgets/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'module.dart';

/// Navigation for weather feature
abstract class WeatherNavigator {
  Widget home();

  toForecastDetails(ForecastWeatherState state);

  back();
}

/// Private implementation if weather navigation
class NavigatorImpl implements WeatherNavigator {
  @override
  home() => const WeatherScreen();

  @override
  toForecastDetails(ForecastWeatherState state) => Modular.to.pushNamed(
        '${WeatherRoutesModule.path}${WeatherRoutesModule.forecast}?${Params.timeEpoch}=${state.dateEpoch}',
        arguments: state,
      );

  @override
  back() => Modular.to.pop();
}
