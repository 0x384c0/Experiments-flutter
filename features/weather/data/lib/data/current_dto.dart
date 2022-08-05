import 'package:json_annotation/json_annotation.dart';
import 'package:domain/data/weather_model.dart';

part 'current_dto.g.dart';

@JsonSerializable()
class CurrentDTO implements WeatherModel {
  CurrentDTO();

  @override
  @JsonKey(name: "temp_c")
  double? temp;

  @override
  @JsonKey(name: "wind_kph")
  double? wind;

  @override
  @JsonKey(name: "humidity")
  double? humidity;

  @override
  @JsonKey(name: "precip_mm")
  double? precipitation;

  @override
  ConditionModel? get condition => conditionDto;

  @JsonKey(name: "condition")
  ConditionDTO? conditionDto;

  factory CurrentDTO.fromJson(Map<String, dynamic> json) =>
      _$CurrentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentDTOToJson(this);
}

@JsonSerializable()
class ConditionDTO implements ConditionModel {
  ConditionDTO();

  @override
  @JsonKey(name: "text")
  String? text;

  @override
  @JsonKey(name: "icon")
  String? icon;

  factory ConditionDTO.fromJson(Map<String, dynamic> json) =>
      _$ConditionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionDTOToJson(this);
}
