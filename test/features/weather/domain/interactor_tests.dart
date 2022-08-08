import 'package:domain/usecases/interactor.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/mock_location.dart';
import '../../../utils/mock_weather_api_impl.dart';
import '../../../utils/test_module.dart';

main() {
  late WeatherInteractor sut;
  setUp(() {
    TestModule.initModules();
    sut = Modular.get<WeatherInteractor>();
  });

  test('get forecast successful', () async {
    final forecast = await sut.getForecast(MockLocation());
    expect(forecast.forecast?.length, MockWeatherApiImpl.forecastItems);
  });

  test('get current successful', () async {
    final current = await sut.getCurrent();
    expect(current.current?.temp, MockWeatherApiImpl.temp);
  });

  test('get forecast item successful', () async {
    final forecastItem = await sut.getForecastItem(MockLocation(), MockWeatherApiImpl.dateEpoch.toString());
    expect(forecastItem?.dateEpoch, MockWeatherApiImpl.dateEpoch);
    expect(forecastItem?.averageTemp, MockWeatherApiImpl.temp);
  });
}
