import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/data/weather_state.dart';
import 'package:presentation/widgets/weather_cubit.dart';

import '../../../utils/test_module.dart';
import 'utils/mock_storage.dart';

main() {
  late WeatherCubit sut;
  setUp(() async {
    TestModule.initModules();
    sut = await mockHydratedStorage(WeatherCubit.new);
  });

  blocTest<WeatherCubit, WeatherState?>(
    'refresh successful',
    build: () => sut,
    act: (cubit) => cubit.refresh(),
    verify: (bloc) => {expect(sut.state?.forecast?.length, 3)}
  );
}
