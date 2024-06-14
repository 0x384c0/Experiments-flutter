import 'package:bloc_test/bloc_test.dart';
import 'package:common_presentation/widgets/page_state/generic_page_state.dart';
import 'package:common_presentation/widgets/page_state/page_state.dart';
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

  blocTest<WeatherCubit, PageState<GenericPageState<WeatherState>>>(
    'refresh successful',
    build: () => sut,
    act: (cubit) => cubit.refresh(),
    verify: (bloc) => {
      expect(
        (sut.state as PageStatePopulated).data.forecast.length,
        MockDatasourceImpl.forecastItems,
      )
    },
  );
}
