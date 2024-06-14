library interactor;

import '../../features_weather_domain.dart';

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
class WeatherInteractorImpl implements WeatherInteractor {
  WeatherInteractorImpl(this.remoteRepository);

  final WeatherRemoteRepository remoteRepository;

  @override
  Future<CurrentModel> getCurrent() => remoteRepository.getCurrent();

  @override
  Future<ForecastModel> getForecast(LocationModel location) => remoteRepository.getForecast(location);

  @override
  Future<ForecastItemModel?> getForecastItem(LocationModel location, String dateEpoch) => remoteRepository
      .getForecast(location)
      .then((value) => value.forecast?.firstWhere((element) => element.dateEpoch.toString() == dateEpoch));
}
