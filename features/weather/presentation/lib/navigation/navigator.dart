import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/widgets/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'routes_module.dart';

/// Navigation for weather feature
abstract class Navigator {
  Widget homePage();

  toForecastDetails(ForecastWeatherState state);

  back();
}

/// Private implementation if weather navigation
class NavigatorImpl implements Navigator {
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
