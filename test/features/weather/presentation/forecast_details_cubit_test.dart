import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/widgets/forecast_details_cubit.dart';

import '../../../utils/mock_weather_api_impl.dart';
import '../../../utils/test_module.dart';
import 'utils/mock_storage.dart';

main() {
  late ForecastDetailsCubit sut;
  setUp(() async {
    TestModule.initModules();
    sut = await mockHydratedStorage(() => ForecastDetailsCubit({MockWeatherApiImpl.dateEpoch.toString(): null}));
  });

  blocTest<ForecastDetailsCubit, Map<String?, ForecastWeatherState?>?>(
      'refresh successful',
      build: () => sut,
      act: (cubit) => cubit.refresh(),
      verify: (bloc) => {expect(sut.state[MockWeatherApiImpl.dateEpoch.toString()]?.temp, '${MockWeatherApiImpl.temp}°')}
  );
}
