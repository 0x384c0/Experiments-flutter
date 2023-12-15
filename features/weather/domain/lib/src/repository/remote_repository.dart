import '../../features_weather_domain.dart';

abstract class WeatherRemoteRepository {
  Future<CurrentModel> getCurrent();

  Future<ForecastModel> getForecast(LocationModel location);
}
