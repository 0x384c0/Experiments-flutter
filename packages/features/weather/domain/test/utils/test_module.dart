import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:get_it/get_it.dart';

import 'mock_datasource_impl.dart';

class TestModule {
  static void initModules() {
    final getIt = GetIt.instance;
    getIt.reset();
    getIt.registerFactory<WeatherRemoteRepository>(() => MockDatasourceImpl());
    getIt.registerFactory<WeatherInteractor>(() => WeatherInteractorImpl(getIt()));
  }
}
