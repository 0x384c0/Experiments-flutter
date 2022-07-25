import 'package:domain/data/forecast_model.dart';
import 'package:domain/data/current_model.dart';
import 'package:domain/data/location_model.dart';

abstract class RemoteDataSource {
  Future<CurrentModel> getCurrent();
  Future<ForecastModel> getForecast(LocationModel location);
}