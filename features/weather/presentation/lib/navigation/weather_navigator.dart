import 'package:flutter_modular/flutter_modular.dart';
import 'package:features_weather_presentation/data/weather_state.dart';

/// Navigation for weather feature
abstract class WeatherNavigator {
  home();

  toForecastDetails(ForecastWeatherState state);

  back();
}

/// Private implementation if weather navigation
class WeatherNavigatorImpl implements WeatherNavigator {

  @override
  home() {
    Modular.to.pushNamed('/');
  }

  @override
  toForecastDetails(ForecastWeatherState state) {
    Modular.to.pushNamed('/forecast?time_epoch=${state.dateEpoch}', arguments: state);
  }

  @override
  back() {
    Modular.to.pop();
  }
}