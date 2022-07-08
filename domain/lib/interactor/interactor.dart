library interactor;

import 'package:domain/data/current_model.dart';
import 'package:domain/data/forecast_model.dart';
import 'package:domain/datasource/remote_data_source.dart';

abstract class WeatherInteractor {
  //TODO: rename to bloc
  Future<CurrentModel> getCurrent();

  Future<ForecastModel> getForecast();
}

class _WeatherInteractorImpl extends WeatherInteractor {
  _WeatherInteractorImpl(this.remoteDataSource);

  late RemoteDataSource remoteDataSource;

  @override
  Future<CurrentModel> getCurrent() {
    return remoteDataSource.getCurrent();
  }

  @override
  Future<ForecastModel> getForecast() {
    return remoteDataSource.getForecast();
  }
}

class DomainModule {
  static WeatherInteractor provideWeatherInteractor(
      RemoteDataSource remoteDataSource) {
    return _WeatherInteractorImpl(remoteDataSource);
  }
}
