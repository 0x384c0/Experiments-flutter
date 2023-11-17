import 'package:features_weather_domain/data/forecast_model.dart';
import 'package:features_weather_domain/data/current_model.dart';
import 'package:features_weather_domain/data/location_model.dart';

abstract class WeatherRemoteRepository {
  Future<CurrentModel> getCurrent();
  Future<ForecastModel> getForecast(LocationModel location);
}