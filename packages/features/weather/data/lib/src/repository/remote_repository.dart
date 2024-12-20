import 'package:features_weather_domain/features_weather_domain.dart';

import '../api/weather_api.dart';

class RemoteRepositoryImpl implements WeatherRemoteRepository {
  RemoteRepositoryImpl(this._weatherApi);

  final String _key = "0bab7dd1bacc418689b143833220304";
  final WeatherApi _weatherApi;

  @override
  Future<CurrentModel> getCurrent() => _weatherApi.getCurrent(_key, "London", false);

  @override
  Future<ForecastModel> getForecast(LocationModel location) =>
      _weatherApi.getForecast(_key, location.toString(), 10, false, false);

  getApi() => _weatherApi;
}
