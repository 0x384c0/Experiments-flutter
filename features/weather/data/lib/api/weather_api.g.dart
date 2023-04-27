// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _WeatherApi implements WeatherApi {
  _WeatherApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://api.weatherapi.com/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ForecastResponseDTO> getCurrent(key, q, aqi) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': key,
      r'q': q,
      r'aqi': aqi
    };
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForecastResponseDTO>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, '/current.json',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForecastResponseDTO.fromJson(result.data!);
    return value;
  }

  @override
  Future<ForecastResponseDTO> getForecast(key, q, days, aqi, alerts) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': key,
      r'q': q,
      r'days': days,
      r'aqi': aqi,
      r'alerts': alerts
    };
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForecastResponseDTO>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, '/forecast.json',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForecastResponseDTO.fromJson(result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
