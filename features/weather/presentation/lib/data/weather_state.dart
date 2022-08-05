import 'package:domain/data/forecast_model.dart';
import 'package:domain/data/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherState {
  // keep in state
  final CurrentWeatherState? current;
  final List<ForecastWeatherState>? forecast;

  WeatherState(this.current, this.forecast);
}

class CurrentWeatherState {
  final String temp;
  final String wind;
  final String humidity;
  final String precipitation;
  final ConditionState condition;

  CurrentWeatherState.fromModel(ForecastModel model)
      : temp = "${model.current?.temp}°",
        wind = "${model.current?.wind} km/h",
        humidity = "${model.current?.humidity}%",
        precipitation = "${model.current?.precipitation} mm",
        condition = ConditionState.fromModel(model.current?.condition);
}

class ForecastWeatherState {
  final String dateEpoch;
  final String date;
  final String temp;
  final String chanceOfRain;
  final String humidity;
  final String wind;
  final ConditionState condition;

  ForecastWeatherState.fromModel(ForecastItemModel model)
      : dateEpoch = "${model.dateEpoch}",
        date =
            DateFormat("EEE, MMM d, yyyy").format(model.date ?? DateTime.now()),
        temp = "${model.averageTemp}°",
        chanceOfRain = "${model.chanceOfRain}%",
        humidity = "${model.averageHumidity}%",
        wind = "${model.maxWind} km/h",
        condition = ConditionState.fromModel(model.condition);
}

class ConditionState {
  final String text;
  final String icon;

  ConditionState.fromModel(ConditionModel? model)
      : text = model?.text ?? "",
        icon = model?.icon?.replaceAll("//", "https://") ?? "";
}
