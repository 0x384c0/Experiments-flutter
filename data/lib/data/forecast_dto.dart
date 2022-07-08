import 'package:json_annotation/json_annotation.dart';

import 'package:domain/data/forecast_model.dart';
import 'package:domain/data/weather_model.dart';
import 'current_dto.dart';

part 'forecast_dto.g.dart';

@JsonSerializable()
class ForecastDto {
  ForecastDto();

  @JsonKey(name: "forecastday")
  List<ForecastDayDto>? forecastDayDto;

  factory ForecastDto.fromJson(Map<String, dynamic> json) =>
      _$ForecastDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastDtoToJson(this);
}

@JsonSerializable()
class ForecastDayDto implements ForecastItemModel {
  ForecastDayDto();

  @override
  @JsonKey(name: "avghumidity")
  double? averageHumidity;

  @override
  @JsonKey(name: "avgtemp_c")
  double? averageTemp;

  @override
  @JsonKey(name: "daily_chance_of_rain")
  double? chanceOfRain;

  @override
  @JsonKey(name: "maxwind_kph")
  double? maxWind;

  @override
  ConditionModel? get condition => conditionDto;

  @JsonKey(name: "condition")
  ConditionDTO? conditionDto;

  factory ForecastDayDto.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastDayDtoToJson(this);
}
