// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentDTO _$CurrentDTOFromJson(Map<String, dynamic> json) => CurrentDTO()
  ..temp = (json['temp_c'] as num?)?.toDouble()
  ..wind = (json['wind_kph'] as num?)?.toDouble()
  ..humidity = (json['humidity'] as num?)?.toDouble()
  ..precipitation = (json['precip_mm'] as num?)?.toDouble()
  ..conditionDto = json['condition'] == null
      ? null
      : ConditionDTO.fromJson(json['condition'] as Map<String, dynamic>);

Map<String, dynamic> _$CurrentDTOToJson(CurrentDTO instance) =>
    <String, dynamic>{
      'temp_c': instance.temp,
      'wind_kph': instance.wind,
      'humidity': instance.humidity,
      'precip_mm': instance.precipitation,
      'condition': instance.conditionDto,
    };

ConditionDTO _$ConditionDTOFromJson(Map<String, dynamic> json) => ConditionDTO()
  ..text = json['text'] as String?
  ..icon = json['icon'] as String?;

Map<String, dynamic> _$ConditionDTOToJson(ConditionDTO instance) =>
    <String, dynamic>{
      'text': instance.text,
      'icon': instance.icon,
    };
