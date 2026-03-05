import 'package:features_weather_data/src/api/weather_api.dart';
import 'package:features_weather_data/src/repository/remote_repository.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:get_it/get_it.dart';

import 'mock_weather_api_impl.dart';

class TestModule {
  static void initModules() {
    final getIt = GetIt.instance;
    getIt.reset();
    getIt.registerFactory<WeatherApi>(() => MockWeatherApiImpl());
    getIt.registerFactory<WeatherRemoteRepository>(() => RemoteRepositoryImpl(getIt()));
  }
}
