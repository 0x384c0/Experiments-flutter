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
class ForecastDayDto implements ForecastItemModel  {
  ForecastDayDto();

  @override
  double? get averageHumidity => dayDto?.averageHumidity;

  @override
  double? get averageTemp => dayDto?.averageTemp;

  @override
  double? get chanceOfRain => dayDto?.chanceOfRain;

  @override
  ConditionModel? get condition => dayDto?.condition;

  @override
  double? get maxWind => dayDto?.maxWind;

  @override
  DateTime? get date => DateTime.tryParse(dateString ?? "");

  @JsonKey(name: "date")
  String? dateString;

  @JsonKey(name: "day")
  DayDto? dayDto;

  @override
  @JsonKey(name: "date_epoch")
  int? dateEpoch;

  factory ForecastDayDto.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastDayDtoToJson(this);
}

@JsonSerializable()
class DayDto{
  DayDto();

  @JsonKey(name: "avghumidity")
  double? averageHumidity;

  @JsonKey(name: "avgtemp_c")
  double? averageTemp;

  @JsonKey(name: "daily_chance_of_rain")
  double? chanceOfRain;

  @JsonKey(name: "maxwind_kph")
  double? maxWind;

  ConditionModel? get condition => conditionDto;

  @JsonKey(name: "condition")
  ConditionDTO? conditionDto;

  factory DayDto.fromJson(Map<String, dynamic> json) =>
      _$DayDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DayDtoToJson(this);
}
