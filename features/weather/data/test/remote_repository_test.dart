import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'utils/mock_location.dart';
import 'utils/mock_weather_api_impl.dart';
import 'utils/test_module.dart';

main() {
  late WeatherRemoteRepository sut;
  setUp(() {
    TestModule.initModules();
    sut = Modular.get<WeatherRemoteRepository>();
  });

  test('get forecast successful', () async {
    final forecast = await sut.getForecast(MockLocation());
    expect(forecast.forecast?.length, MockWeatherApiImpl.forecastItems);
    expect(forecast.forecast?.first.dateEpoch, MockWeatherApiImpl.dateEpoch);
  });

  test('get current successful', () async {
    final current = await sut.getCurrent();
    expect(current.current?.temp, MockWeatherApiImpl.temp);
  });
}

class MForecastItemModel extends Mock implements ForecastItemModel {}
