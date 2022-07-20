import 'weather_model.dart';

abstract class ForecastModel {
  final WeatherModel? current;
  final List<ForecastItemModel>? forecast;

  ForecastModel(this.current, this.forecast);
}

abstract class ForecastItemModel {
  final DateTime? date;
  final double? averageTemp;
  final double? chanceOfRain;
  final double? averageHumidity;
  final double? maxWind;
  final ConditionModel? condition;

  ForecastItemModel(this.date, this.averageTemp, this.chanceOfRain,
      this.averageHumidity, this.maxWind, this.condition);
}
