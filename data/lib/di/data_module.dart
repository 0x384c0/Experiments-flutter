import 'package:data/api/weather_api.dart';
import 'package:data/datasource/remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:domain/datasource/remote_data_source.dart';
import 'package:flutter_modular/flutter_modular.dart';


class DataModule extends Module {
  @override
  List<Bind> get binds => [
    Bind<RemoteDataSource>(
          (i) => RemoteDataSourceImpl(WeatherApi(Dio())),
      export: true,
    ),
  ];
}