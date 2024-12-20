import 'package:dio/dio.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../api/weather_api.dart';
import '../repository/remote_repository.dart';

class WeatherDataModule extends Module {

  @override
  exportedBinds(Injector i) {
    i.add<WeatherApi>(() => WeatherApi(Dio()));
    i.add<WeatherRemoteRepository>(RemoteRepositoryImpl.new);
  }
}
