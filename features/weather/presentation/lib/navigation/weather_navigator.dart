import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/weather_page.dart';
import 'routes_module.dart';

/// Navigation for weather feature
abstract class WeatherNavigator {
  Widget homePage();

  toForecastDetails(ForecastWeatherState state);

  back();
}

/// Private implementation if weather navigation
class WeatherNavigatorImpl implements WeatherNavigator {
  @override
  homePage() {
    return const WeatherPage();
  }

  @override
  toForecastDetails(ForecastWeatherState state) {
    Modular.to.pushNamed('${RoutesModule.path}/forecast?time_epoch=${state.dateEpoch}', arguments: state);
  }

  @override
  back() {
    Modular.to.pop();
  }
}
