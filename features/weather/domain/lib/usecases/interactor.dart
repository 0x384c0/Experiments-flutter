library interactor;

import 'package:features_weather_domain/data/current_model.dart';
import 'package:features_weather_domain/data/forecast_model.dart';
import 'package:features_weather_domain/data/location_model.dart';
import 'package:features_weather_domain/repository/remote_repository.dart';

/// requests information about weather in area
abstract class WeatherInteractor {
  /// return [Future] with request information about weather today
  Future<CurrentModel> getCurrent();
  /// return [Future] with request information weather forecast for n days for [location]. n  depends of API limitations
  Future<ForecastModel> getForecast(LocationModel location);
  /// return [Future] with request information weather forecast for specific [dateEpoch] for [location]
  Future<ForecastItemModel?> getForecastItem(LocationModel location, String dateEpoch);
}

/// private implementation of [WeatherInteractor]
class WeatherInteractorImpl extends WeatherInteractor {
  WeatherInteractorImpl(this.remoteRepository);

  RemoteRepository remoteRepository;

  @override
  Future<CurrentModel> getCurrent() {
    return remoteRepository.getCurrent();
  }

  @override
  Future<ForecastModel> getForecast(LocationModel location) {
    return remoteRepository.getForecast(location);
  }

  @override
  Future<ForecastItemModel?> getForecastItem(LocationModel location, String dateEpoch) {
    return remoteRepository.getForecast(location)
        .then((value) => value.forecast?.firstWhere((element) => element.dateEpoch.toString() == dateEpoch));
  }
}
