import 'package:features_weather_domain/features_weather_domain.dart';

import '../api/weather_api.dart';

class RemoteRepositoryImpl implements WeatherRemoteRepository {
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
