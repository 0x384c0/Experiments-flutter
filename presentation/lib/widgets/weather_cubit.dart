import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:domain/interactor/interactor.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/data/location_state.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/utils/geo_location.dart';
import 'package:presentation/navigation/weather_navigator.dart';

class WeatherCubit extends Cubit<WeatherState?> {
  WeatherCubit() : super(null);

  late WeatherInteractor interactor = Modular.get<WeatherInteractor>();
  late WeatherNavigator navigator = Modular.get<WeatherNavigator>();

  Future<void> refresh() async {
    //TODO: handle errors
    final position = await GeoLocation.getPosition();
    final forecast =
        await interactor.getForecast(LocationState.fromPosition(position));
    final weather = WeatherState(
      CurrentWeatherState.fromModel(forecast),
      forecast.forecast?.map((e) => ForecastWeatherState.fromModel(e)).toList(),
    );
    emit(weather);
  }

  void onForecastClick(ForecastWeatherState state) {
    navigator.toForecastDetails(state);
  }
}
