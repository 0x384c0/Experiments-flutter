import 'weather_model.dart';

abstract class CurrentModel {
  final WeatherModel? current;

  CurrentModel(this.current);
}