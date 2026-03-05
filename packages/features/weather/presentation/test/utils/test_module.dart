import 'package:common_domain/mapper/mapper.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:features_weather_presentation/src/data/location_state.dart';
import 'package:features_weather_presentation/src/data/weather_state.dart';
import 'package:features_weather_presentation/src/mapper/condition_model_mapper.dart';
import 'package:features_weather_presentation/src/mapper/forecast_item_model_mapper.dart';
import 'package:features_weather_presentation/src/mapper/forecast_model_mapper.dart';
import 'package:features_weather_presentation/src/utils/geo_location_provider.dart';
import 'package:features_weather_presentation/src/widgets/forecast_details_cubit.dart';
import 'package:features_weather_presentation/src/widgets/weather_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_datasource_impl.dart';

class MockGeoLocationProviderImpl extends Mock implements GeoLocationProvider {}

class TestModule {
  static void initModules() {
    final getIt = GetIt.instance;
    getIt.reset();

    // Domain
    getIt.registerFactory<WeatherRemoteRepository>(() => MockDatasourceImpl());
    getIt.registerFactory<WeatherInteractor>(() => WeatherInteractorImpl(getIt()));

    // Mappers
    getIt.registerFactory<ConditionModelMapper>(() => ConditionModelMapper());
    getIt.registerFactory<Mapper<ForecastItemModel, ForecastWeatherState>>(
        () => ForecastItemModelMapper(getIt()));
    getIt.registerFactory<Mapper<ForecastModel, WeatherState>>(
        () => ForecastModelMapper(getIt(), getIt()));

    // Utils
    final mockGeoLocationProvider = MockGeoLocationProviderImpl();
    when(() => mockGeoLocationProvider.getLocation()).thenAnswer(
        (_) async => const LocationState(latitude: 40.7128, longitude: 74.0060));
    getIt.registerFactory<GeoLocationProvider>(() => mockGeoLocationProvider);

    // Cubits
    getIt.registerFactory<WeatherCubit>(() => WeatherCubit(getIt(), getIt(), getIt()));
    getIt.registerFactoryParam<ForecastDetailsCubit, Map<String?, ForecastWeatherState?>, void>(
        (param1, _) => ForecastDetailsCubit(param1, getIt(), getIt(), getIt()));
  }
}
