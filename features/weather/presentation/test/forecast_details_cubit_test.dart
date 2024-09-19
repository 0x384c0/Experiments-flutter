import 'package:bloc_test/bloc_test.dart';
import 'package:common_presentation/widgets/page_state/generic_screen_state.dart';
import 'package:common_presentation/widgets/page_state/screen_state.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:features_weather_presentation/src/widgets/forecast_details_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/mock_datasource_impl.dart';
import 'utils/mock_storage.dart';
import 'utils/test_module.dart';

main() {
  late ForecastDetailsCubit sut;
  setUp(() async {
    TestModule.initModules();
    mockHydratedStorage();
    sut = ForecastDetailsCubit({MockDatasourceImpl.dateEpoch.toString(): null});
  });

  blocTest<ForecastDetailsCubit, ScreenState<GenericScreenState<Map<String?, ForecastWeatherState?>>>>('refresh successful',
      build: () => sut,
      act: (cubit) => cubit.refresh(),
      verify: (bloc) =>
          {expect(sut.stateData?.data[MockDatasourceImpl.dateEpoch.toString()]?.temp, '${MockDatasourceImpl.temp}°')});
}
