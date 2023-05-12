import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:features_weather_presentation/data/weather_state.dart';
import 'package:features_weather_presentation/widgets/weather_cubit.dart';

import '../../../utils/mock_weather_api_impl.dart';
import '../../../utils/test_module.dart';
import 'utils/mock_storage.dart';

main() {
  late WeatherCubit sut;
  setUp(() async {
    TestModule.initModules();
    sut = await mockHydratedStorage(WeatherCubit.new);
  });

  blocTest<WeatherCubit, WeatherState>(
    'refresh successful',
    build: () => sut,
    act: (cubit) => cubit.refresh(),
    verify: (bloc) => {expect((sut.state as WeatherStatePopulated).forecast.length, MockWeatherApiImpl.forecastItems)}
  );
}
