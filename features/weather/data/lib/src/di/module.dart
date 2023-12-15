import 'package:dio/dio.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../api/weather_api.dart';
import '../repository/remote_repository.dart';

class WeatherDataModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance(WeatherApi(Dio()));
  }

  @override
  exportedBinds(Injector i) {
    i.addSingleton<WeatherRemoteRepository>(RemoteRepositoryImpl.new);
  }
}
