import 'weather_model.dart';

abstract class ForecastModel {
  ForecastModel(this.current, this.forecast);

  final WeatherModel? current;
  final List<ForecastItemModel>? forecast;
}

abstract class ForecastItemModel {
  ForecastItemModel(this.averageTemp, this.chanceOfRain, this.averageHumidity,
      this.maxWind, this.condition);

  final double? averageTemp;
  final double? chanceOfRain;
  final double? averageHumidity;
  final double? maxWind;
  final ConditionModel? condition;
}
