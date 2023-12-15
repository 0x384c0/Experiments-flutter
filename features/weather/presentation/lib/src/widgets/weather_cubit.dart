import 'package:common_domain/mapper/mapper.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/weather_state.dart';
import '../navigation/navigator.dart';
import '../utils/geo_location_provider.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherStateEmpty());

  late WeatherInteractor interactor = Modular.get();
  late WeatherNavigator navigator = Modular.get();
  late GeoLocationProvider geoLocationManager = Modular.get();
  late Mapper<ForecastModel, WeatherState> forecastModelMapper = Modular.get();

  Future<void> refresh() async {
    return geoLocationManager
        .getLocation()
        .then((value) => interactor.getForecast(value))
        .then(forecastModelMapper.map)
        .catchError(catchError)
        .then(emit);
  }

  void onForecastClick(ForecastWeatherState state) {
    navigator.toForecastDetails(state);
  }

  WeatherState catchError(Object e) => WeatherStateError(e);
}
