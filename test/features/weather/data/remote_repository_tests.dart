import 'package:domain/repository/remote_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/mock_location.dart';
import '../../../utils/mock_weather_api_impl.dart';
import '../../../utils/test_module.dart';

main() {
  late RemoteRepository sut;
  setUp(() {
    TestModule.initModules();
    sut = Modular.get<RemoteRepository>();
  });

  test('get forecast successful', () async {
    final forecast = await sut.getForecast(MockLocation());
    expect(forecast.forecast?.length, MockWeatherApiImpl.forecastItems);
  });

  test('get current successful', () async {
    final current = await sut.getCurrent();
    expect(current.current?.temp, MockWeatherApiImpl.temp);
  });
}
