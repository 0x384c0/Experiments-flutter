import 'package:features_weather_data/api/weather_api.dart';
import 'package:features_weather_data/repository/remote_repository.dart';
import 'package:dio/dio.dart';
import 'package:features_weather_domain/repository/remote_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WeatherDataModule extends Module {
  @override
  void binds(Injector i) {
    i.add<WeatherApi>(() => WeatherApi(Dio()));
  }

  @override
  exportedBinds(Injector i) {
    i.addSingleton<WeatherRemoteRepository>(RemoteRepositoryImpl.new);
  }
}
