import 'package:domain/data/weather_model.dart';

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

  CurrentWeatherState(
      this.temp, this.wind, this.humidity, this.precipitation, this.condition);
}

class ForecastWeatherState {
  final String dateEpoch;
  final String date;
  final String temp;
  final String chanceOfRain;
  final String humidity;
  final String wind;
  final ConditionState condition;

  ForecastWeatherState(this.dateEpoch ,this.date, this.temp, this.chanceOfRain, this.humidity,
      this.wind, this.condition);
}

class ConditionState {
  final String text;
  final String icon;

  ConditionState(this.text,this.icon);//TODO: remove

  ConditionState.fromModel(ConditionModel? conditionModel)
      : text = conditionModel?.text ?? "",
        icon = conditionModel?.icon?.replaceAll("//", "https://") ?? "";
}
