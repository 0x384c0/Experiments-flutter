import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:features_weather_presentation/features_weather_presentation.dart';
import 'package:features_weather_presentation/src/utils/geo_location_provider.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'mock_datasource_impl.dart';
import 'mock_location_manager.dart';

class TestModule extends Module {
  @override
  List<Module> get imports => [
        WeatherDomainModule(),
        WeatherPresentationModule(),
      ];

  static void initModules() {
    Modular.bindModule(TestModule());
    Modular.replaceInstance<GeoLocationProvider>(MockGeoLocationProviderImpl());
    Modular.replaceInstance<WeatherRemoteRepository>(MockDatasourceImpl());
  }
}
