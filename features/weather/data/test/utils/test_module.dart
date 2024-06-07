import 'package:features_weather_data/features_weather_data.dart';
import 'package:features_weather_data/src/api/weather_api.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'mock_weather_api_impl.dart';

class TestModule extends Module {
  @override
  List<Module> get imports => [WeatherDataModule()];

  static void initModules() {
    Modular.bindModule(TestModule());
    Modular.replaceInstance<WeatherApi>(MockWeatherApiImpl()); // will not work for singletons, when it is obtained as parameter. Though will work if requested with Modular.get()
  }
}
