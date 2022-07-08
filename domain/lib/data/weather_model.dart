abstract class WeatherModel {
  final double? temp;
  final double? wind;
  final double? humidity;
  final double? precipitation;
  final ConditionModel? condition;

  WeatherModel(this.temp, this.wind, this.humidity, this.precipitation, this.condition);
}

abstract class ConditionModel {
  final String? text;
  final String? icon;

  ConditionModel(this.text, this.icon);
}