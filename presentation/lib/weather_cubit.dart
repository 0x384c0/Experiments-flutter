import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:domain/interactor/interactor.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/utils/geo_location.dart';
import 'package:presentation/navigation/weather_navigator.dart';
import 'data/location_state.dart';
import 'data/weather_state.dart';

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
      CurrentWeatherState(
        "${forecast.current?.temp}°",
        "${forecast.current?.wind} km/h",
        "${forecast.current?.humidity}%",
        "${forecast.current?.precipitation} mm",
        ConditionState.fromModel(forecast.current?.condition),
      ),
      forecast.forecast
          ?.map((e) => ForecastWeatherState.fromModel(e)).toList(),
    );
    emit(weather);
  }

  void onForecastClick(ForecastWeatherState state) {
    navigator.toForecastDetails(state);
  }
}
