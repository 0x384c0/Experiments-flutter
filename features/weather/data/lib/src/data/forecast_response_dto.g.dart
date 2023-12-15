// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastResponseDTO _$ForecastResponseDTOFromJson(Map<String, dynamic> json) =>
    ForecastResponseDTO()
      ..currentDto = json['current'] == null
          ? null
          : CurrentDTO.fromJson(json['current'] as Map<String, dynamic>)
      ..forecastDto = json['forecast'] == null
          ? null
          : ForecastDto.fromJson(json['forecast'] as Map<String, dynamic>);

Map<String, dynamic> _$ForecastResponseDTOToJson(
        ForecastResponseDTO instance) =>
    <String, dynamic>{
      'current': instance.currentDto,
      'forecast': instance.forecastDto,
    };
