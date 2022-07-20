import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:domain/interactor/interactor.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState?> {
  WeatherCubit(this.interactor) : super(null);

  WeatherInteractor interactor;

  Future<void> refresh() async {
    final formatter = DateFormat("EEE, MMM d, yyyy");
    final forecast = await interactor.getForecast();
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
}
