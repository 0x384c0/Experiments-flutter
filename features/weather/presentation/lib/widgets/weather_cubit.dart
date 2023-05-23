import 'package:features_weather_domain/data/forecast_model.dart';
import 'package:features_weather_domain/usecases/interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/navigation/weather_navigator.dart';
import 'package:features_weather_presentation/utils/geo_location_provider.dart';
import 'package:features_weather_presentation/utils/mapper.dart';

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
