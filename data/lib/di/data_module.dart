import 'package:data/api/weather_api.dart';
import 'package:data/repository/remote_repository.dart';
import 'package:dio/dio.dart';
import 'package:domain/repository/remote_repository.dart';
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