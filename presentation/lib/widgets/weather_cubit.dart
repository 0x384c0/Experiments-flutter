import 'package:domain/data/forecast_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:domain/interactor/interactor.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/data/location_state.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/utils/geo_location.dart';
import 'package:presentation/navigation/weather_navigator.dart';
import 'package:presentation/utils/mapper.dart';

class WeatherCubit extends Cubit<WeatherState?> {
  WeatherCubit() : super(null);

  late WeatherInteractor interactor = Modular.get();
  late WeatherNavigator navigator = Modular.get();
  late Mapper<ForecastModel, WeatherState> forecastModelMapper = Modular.get();

  Future<void> refresh() async {
    return GeoLocation.getPosition()
        .then((value) => LocationState.fromPosition(value))
        .then((value) => interactor.getForecast(value))
        .then(forecastModelMapper.map)
        .then(emit);
  }

  void onForecastClick(ForecastWeatherState state) {
    navigator.toForecastDetails(state);
  }
}
