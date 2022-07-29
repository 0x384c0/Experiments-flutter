import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:domain/interactor/interactor.dart';
import 'package:presentation/utils/geo_location.dart';
import 'package:presentation/navigation/weather_navigator.dart';
import 'data/location_state.dart';
import 'data/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState?> {
  WeatherCubit(this.interactor, this.navigator) : super(null);

  WeatherInteractor interactor;
  WeatherNavigator navigator;

  Future<void> refresh() async {
    //TODO: handle errors
    final formatter = DateFormat("EEE, MMM d, yyyy");
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
          ?.map((e) => ForecastWeatherState(
                "${e.dateEpoch}",
                formatter.format(e.date ?? DateTime.now()),
                "${e.averageTemp}°",
                "${e.chanceOfRain}%",
                "${e.averageHumidity}%",
                "${e.maxWind} km/h",
                ConditionState.fromModel(e.condition),
              ))
          .toList(),
    );
    emit(weather);
  }

  void onForecastClick(ForecastWeatherState state) {
    navigator.toForecastDetails(state);
  }
}
