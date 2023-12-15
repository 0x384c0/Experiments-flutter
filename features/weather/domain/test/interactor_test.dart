import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/mock_datasource_impl.dart';
import 'utils/mock_location.dart';
import 'utils/test_module.dart';


main() {
  late WeatherInteractor sut;
  setUp(() {
    TestModule.initModules();
    sut = Modular.get<WeatherInteractor>();
  });

  test('get forecast successful', () async {
    final forecast = await sut.getForecast(MockLocation());
    expect(forecast.forecast?.length, MockDatasourceImpl.forecastItems);
  });

  test('get current successful', () async {
    final current = await sut.getCurrent();
    expect(current.current?.temp, MockDatasourceImpl.temp);
  });

  test('get forecast item successful', () async {
    final forecastItem = await sut.getForecastItem(MockLocation(), MockDatasourceImpl.dateEpoch.toString());
    expect(forecastItem?.dateEpoch, MockDatasourceImpl.dateEpoch);
    expect(forecastItem?.averageTemp, MockDatasourceImpl.temp);
  });
}
