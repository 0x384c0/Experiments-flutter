// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastDto _$ForecastDtoFromJson(Map<String, dynamic> json) => ForecastDto()
  ..forecastDayDto = (json['forecastday'] as List<dynamic>?)
      ?.map((e) => ForecastDayDto.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ForecastDtoToJson(ForecastDto instance) =>
    <String, dynamic>{
      'forecastday': instance.forecastDayDto,
    };

ForecastDayDto _$ForecastDayDtoFromJson(Map<String, dynamic> json) =>
    ForecastDayDto()
      ..dateString = json['date'] as String?
      ..dayDto = json['day'] == null
          ? null
          : DayDto.fromJson(json['day'] as Map<String, dynamic>)
      ..dateEpoch = json['date_epoch'] as int?;

Map<String, dynamic> _$ForecastDayDtoToJson(ForecastDayDto instance) =>
    <String, dynamic>{
      'date': instance.dateString,
      'day': instance.dayDto,
      'date_epoch': instance.dateEpoch,
    };

DayDto _$DayDtoFromJson(Map<String, dynamic> json) => DayDto()
  ..averageHumidity = (json['avghumidity'] as num?)?.toDouble()
  ..averageTemp = (json['avgtemp_c'] as num?)?.toDouble()
  ..chanceOfRain = (json['daily_chance_of_rain'] as num?)?.toDouble()
  ..maxWind = (json['maxwind_kph'] as num?)?.toDouble()
  ..conditionDto = json['condition'] == null
      ? null
      : ConditionDTO.fromJson(json['condition'] as Map<String, dynamic>);

Map<String, dynamic> _$DayDtoToJson(DayDto instance) => <String, dynamic>{
      'avghumidity': instance.averageHumidity,
      'avgtemp_c': instance.averageTemp,
      'daily_chance_of_rain': instance.chanceOfRain,
      'maxwind_kph': instance.maxWind,
      'condition': instance.conditionDto,
    };
