import 'package:bloc_test/bloc_test.dart';
import 'package:common_presentation/widgets/page_state/generic_screen_state.dart';
import 'package:common_presentation/widgets/page_state/screen_state.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:features_weather_presentation/src/widgets/weather_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/mock_datasource_impl.dart';
import 'utils/mock_storage.dart';
import 'utils/test_module.dart';

main() {
  late WeatherCubit sut;
  setUp(() async {
    TestModule.initModules();
    mockHydratedStorage();
    sut = WeatherCubit();
  });

  blocTest<WeatherCubit, ScreenState<GenericScreenState<WeatherState>>>(
    'refresh successful',
    build: () => sut,
    act: (cubit) => cubit.refresh(),
    verify: (bloc) => {
      expect(
        (sut.state as ScreenStatePopulated).data.forecast.length,
        MockDatasourceImpl.forecastItems,
      )
    },
  );
}
