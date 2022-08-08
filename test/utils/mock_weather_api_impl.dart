import 'package:data/api/weather_api.dart';
import 'package:data/data/current_dto.dart';
import 'package:data/data/forecast_response_dto.dart';
import 'package:domain/data/forecast_model.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherApiImpl implements WeatherApi {
   static const temp = 19.0;
   static const forecastItems = 3;
   static const dateEpoch = 1659657600;

  MockWeatherApiImpl() {
    when(() => _response.current).thenReturn(_responseWeather);
    when(() => _responseWeather.temp).thenReturn(temp);

    when(() => _response.forecast).thenReturn(Iterable.generate(forecastItems).map((e) => _responseForecastItem).toList());
    when(() => _responseForecastItem.averageTemp).thenReturn(temp);
    when(() => _responseForecastItem.dateEpoch).thenReturn(dateEpoch);
  }

  @override
  Future<ForecastResponseDTO> getCurrent(String key, String q, bool aqi) => Future.value(_response);

  @override
  Future<ForecastResponseDTO> getForecast(String key, String q, int days, bool aqi, bool alerts) =>
      Future.value(_response);

  final MockForecastResponseDTO _response = MockForecastResponseDTO();
  final MockWeatherModel _responseWeather = MockWeatherModel();
  final MockForecastItemModel _responseForecastItem = MockForecastItemModel();
}

class MockForecastResponseDTO extends Mock implements ForecastResponseDTO {}

class MockWeatherModel extends Mock implements CurrentDTO {}

class MockForecastItemModel extends Mock implements ForecastItemModel {}
