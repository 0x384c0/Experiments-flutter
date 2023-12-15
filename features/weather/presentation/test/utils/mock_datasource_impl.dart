import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:mocktail/mocktail.dart';

class MockDatasourceImpl implements WeatherRemoteRepository {
  static const temp = 19.0;
  static const forecastItems = 7;
  static const dateEpoch = 1659657600;

  MockDatasourceImpl() {
    when(() => _currentModel.current).thenReturn(_mockWeatherModel);
    when(() => _mockForecastModel.current).thenReturn(_mockWeatherModel);

    when(() => _mockWeatherModel.temp).thenReturn(temp);

    when(() => _forecastModel.forecast)
        .thenReturn(Iterable.generate(forecastItems).map((e) => _forecastItemModel).toList());
    when(() => _forecastItemModel.averageTemp).thenReturn(temp);
    when(() => _forecastItemModel.dateEpoch).thenReturn(dateEpoch);
  }

  @override
  Future<CurrentModel> getCurrent() => Future.value(_currentModel);

  @override
  Future<ForecastModel> getForecast(LocationModel location) => Future.value(_forecastModel);

  final CurrentModel _currentModel = MockCurrentModel();

  final ForecastModel _forecastModel = MockForecastModel();

  final MockForecastModel _mockForecastModel = MockForecastModel();
  final MockWeatherModel _mockWeatherModel = MockWeatherModel();
  final ForecastItemModel _forecastItemModel = MockForecastItemModel();
}

class MockCurrentModel extends Mock implements CurrentModel {}

class MockForecastModel extends Mock implements ForecastModel {}

class MockWeatherModel extends Mock implements WeatherModel {}

class MockForecastItemModel extends Mock implements ForecastItemModel {}
