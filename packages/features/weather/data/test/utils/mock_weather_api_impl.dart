import 'package:features_weather_data/src/api/weather_api.dart';
import 'package:features_weather_data/src/data/current_dto.dart';
import 'package:features_weather_data/src/data/forecast_response_dto.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherApiImpl implements WeatherApi {
  static const temp = 19.0;
  static const forecastItems = 7;
  static const dateEpoch = 1659657600;

  MockWeatherApiImpl() {
    when(() => _mockCurrentDTO.temp).thenReturn(temp);
    when(() => mockForecastResponseDTO.current).thenReturn(_mockCurrentDTO);

    when(() => mockForecastResponseDTO.forecast).thenReturn(
      Iterable.generate(forecastItems).map((e) => _mockForecastItemModel).toList(),
    );
    when(() => _mockForecastItemModel.averageTemp).thenReturn(temp);
    when(() => _mockForecastItemModel.dateEpoch).thenReturn(dateEpoch);
  }

  @override
  Future<ForecastResponseDTO> getCurrent(String key, String q, bool aqi) => Future.value(mockForecastResponseDTO);

  @override
  Future<ForecastResponseDTO> getForecast(String key, String q, int days, bool aqi, bool alerts) =>
      Future.value(mockForecastResponseDTO);

  static final ForecastResponseDTO mockForecastResponseDTO = _MockForecastResponseDTO();
  final CurrentDTO _mockCurrentDTO = _MockCurrentDTO();
  final ForecastItemModel _mockForecastItemModel = _MockForecastItemModel();

}

class _MockForecastResponseDTO extends Mock implements ForecastResponseDTO {}

class _MockCurrentDTO extends Mock implements CurrentDTO {}

class _MockForecastItemModel extends Mock implements ForecastItemModel {}
