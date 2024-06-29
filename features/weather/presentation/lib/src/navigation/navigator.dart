import '../data/weather_state.dart';
import '../widgets/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'module.dart';

/// Navigation for weather feature
abstract class WeatherNavigator {
  Widget homePage();

  toForecastDetails(ForecastWeatherState state);

  back();
}

/// Private implementation if weather navigation
class NavigatorImpl implements WeatherNavigator {
  @override
  homePage() => const WeatherPage();

  @override
  toForecastDetails(ForecastWeatherState state) => Modular.to.pushNamed(
        '${WeatherRoutesModule.path}${WeatherRoutesModule.forecast}?${Params.timeEpoch}=${state.dateEpoch}',
        arguments: state,
      );

  @override
  back() => Modular.to.pop();
}
