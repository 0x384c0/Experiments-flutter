import 'package:features_weather_data/api/weather_api.dart';
import 'package:features_weather_data/repository/remote_repository.dart';
import 'package:dio/dio.dart';
import 'package:features_weather_domain/repository/remote_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DataModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<WeatherApi>(
          (i) => WeatherApi(Dio()),
          export: true,
        ),
        Bind<RemoteRepository>(
          (i) => RemoteRepositoryImpl(i()),
          export: true,
        ),
      ];
}