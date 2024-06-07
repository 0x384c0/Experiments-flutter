import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'mock_datasource_impl.dart';

class _MockDataModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<WeatherRemoteRepository>(MockDatasourceImpl.new);
  }
}

class TestModule extends Module {
  @override
  List<Module> get imports => [
        WeatherDomainModule([_MockDataModule()]),
      ];

  static void initModules() {
    Modular.bindModule(TestModule());
  }
}
