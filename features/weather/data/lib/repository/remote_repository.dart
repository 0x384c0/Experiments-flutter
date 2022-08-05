library data;

import 'package:data/api/weather_api.dart';
import 'package:domain/data/current_model.dart';
import 'package:domain/data/forecast_model.dart';
import 'package:domain/data/location_model.dart';
import 'package:domain/repository/remote_repository.dart';

class RemoteRepositoryImpl implements RemoteRepository {
  RemoteRepositoryImpl(this.weatherApi);

  String key = "0bab7dd1bacc418689b143833220304"; //TODO: move to config
  WeatherApi weatherApi;

  @override
  Future<CurrentModel> getCurrent() {
    return weatherApi.getCurrent(key, "London", false);
  }

  @override
  Future<ForecastModel> getForecast(LocationModel location) {
    return weatherApi.getForecast(key, location.toString(), 10, false, false);
  }
}
