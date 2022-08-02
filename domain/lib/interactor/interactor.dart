library interactor;

import 'package:domain/data/current_model.dart';
import 'package:domain/data/forecast_model.dart';
import 'package:domain/data/location_model.dart';
import 'package:domain/datasource/remote_data_source.dart';

abstract class WeatherInteractor {
  //TODO: rename to bloc
  //TODO: unit tests
  Future<CurrentModel> getCurrent();

  Future<ForecastModel> getForecast(LocationModel location);
}

class WeatherInteractorImpl extends WeatherInteractor {
  WeatherInteractorImpl(this.remoteDataSource);

  late RemoteDataSource remoteDataSource;

  @override
  Future<CurrentModel> getCurrent() {
    return remoteDataSource.getCurrent();
  }

  @override
  Future<ForecastModel> getForecast(LocationModel location) {
    return remoteDataSource.getForecast(location);
  }
}
