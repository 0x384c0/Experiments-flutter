import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../data/forecast_response_dto.dart';
part 'weather_api.g.dart';

@RestApi(baseUrl: "https://api.weatherapi.com/v1")
abstract class WeatherApi {
  factory WeatherApi(Dio dio, {String baseUrl}) = _WeatherApi;

  @GET("/current.json")
  Future<ForecastResponseDTO> getCurrent(
    @Query("key") String key,
    @Query("q") String q,
    @Query("aqi") bool aqi,
  );

  @GET("/forecast.json")
  Future<ForecastResponseDTO> getForecast(
    @Query("key") String key,
    @Query("q") String q,
    @Query("days") int days,
    @Query("aqi") bool aqi,
    @Query("alerts") bool alerts,
  );
}
