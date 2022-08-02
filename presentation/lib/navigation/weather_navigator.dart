import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/data/weather_state.dart';

abstract class WeatherNavigator {
  toForecastDetails(ForecastWeatherState state);

  back();
}

class WeatherNavigatorImpl implements WeatherNavigator {

  @override
  toForecastDetails(ForecastWeatherState state) {
    Modular.to.pushNamed('/forecast?time_epoch=${state.dateEpoch}', arguments: state);
  }

  @override
  back() {
    Modular.to.pop();
  }
}