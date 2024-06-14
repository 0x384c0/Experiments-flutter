import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:features_weather_presentation/features_weather_presentation.dart';
import 'package:features_weather_presentation/src/utils/geo_location_provider.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'mock_datasource_impl.dart';

class _MockDataModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add<WeatherRemoteRepository>(MockDatasourceImpl.new);
  }
}

class TestModule extends Module {
  @override
  List<Module> get imports => [
        WeatherDomainModule([_MockDataModule()]),
        WeatherPresentationModule(isRealDevice: false),
      ];

  static void initModules() {
    Modular.bindModule(TestModule());
    Modular.replaceInstance<GeoLocationProvider>(MockGeoLocationProviderImpl());
  }
}
