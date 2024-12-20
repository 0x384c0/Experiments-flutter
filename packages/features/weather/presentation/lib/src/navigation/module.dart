import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:features_weather_presentation/src/widgets/forecast_details_screen.dart';
import 'package:features_weather_presentation/src/widgets/weather_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WeatherRoutesModule extends Module {
  static const path = '/weather';
  static const forecast = '/forecast';

  @override
  void routes(r) {
    r.child('/', child: (context) => const WeatherScreen());
    r.child(
      forecast,
      child: (context) => ForecastDetailsScreen(args: {
        r.args.queryParams[Params.timeEpoch]: r.args.data is ForecastWeatherState ? r.args.data : null,
      }),
    );
  }
}

class Params {
  static const timeEpoch = 'time_epoch';
}
