import 'package:json_annotation/json_annotation.dart';

import 'package:features_weather_domain/data/forecast_model.dart';
import 'package:features_weather_domain/data/current_model.dart';
import 'package:features_weather_domain/data/weather_model.dart';
import 'current_dto.dart';
import 'forecast_dto.dart';

part 'forecast_response_dto.g.dart';

@JsonSerializable()
class ForecastResponseDTO implements ForecastModel, CurrentModel {
  ForecastResponseDTO();

  @override
  WeatherModel? get current => currentDto;

  @override
  List<ForecastItemModel>? get forecast => forecastDto?.forecastDayDto;

  @JsonKey(name: "current")
  CurrentDTO? currentDto;

  @JsonKey(name: "forecast")
  ForecastDto? forecastDto;

  factory ForecastResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastResponseDTOToJson(this);
}