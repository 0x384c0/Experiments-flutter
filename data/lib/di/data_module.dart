import 'package:data/api/weather_api.dart';
import 'package:data/datasource/remote_repository.dart';
import 'package:dio/dio.dart';
import 'package:domain/datasource/remote_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DataModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<RemoteRepository>(
          (i) => RemoteRepositoryImpl(WeatherApi(Dio())),
          export: true,
        ),
      ];
}
