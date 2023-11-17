import 'package:features_weather_data/api/weather_api.dart';
import 'package:features_weather_data/di/data_module.dart';
import 'package:features_weather_domain/di/domain_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:features_weather_presentation/di/presentation_module.dart';
import 'package:features_weather_presentation/utils/geo_location_provider.dart';

import 'mock_location_manager.dart';
import 'mock_weather_api_impl.dart';

class TestModule extends Module {
  @override
  List<Module> get imports => [
        WeatherDataModule(),
        WeatherDomainModule(),
        WeatherPresentationModule(),
      ];

  static void initModules() {
    Modular.bindModule(TestModule());
    Modular.replaceInstance<WeatherApi>(MockWeatherApiImpl());
    Modular.replaceInstance<GeoLocationProvider>(MockGeoLocationProviderImpl());
  }
}
