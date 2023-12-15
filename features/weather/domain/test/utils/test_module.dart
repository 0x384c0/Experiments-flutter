import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'mock_datasource_impl.dart';

class TestModule extends Module {
  @override
  List<Module> get imports => [
        WeatherDomainModule(),
      ];

  static void initModules() {
    Modular.bindModule(TestModule());
    Modular.replaceInstance<WeatherRemoteRepository>(MockDatasourceImpl());
  }
}
