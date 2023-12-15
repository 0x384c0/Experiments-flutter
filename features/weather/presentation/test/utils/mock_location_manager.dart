import 'package:features_weather_presentation/src/data/location_state.dart';
import 'package:features_weather_presentation/src/utils/geo_location_provider.dart';

class MockGeoLocationProviderImpl implements GeoLocationProvider {
  @override
  Future<LocationState> getLocation() => Future.value(const LocationState(latitude: 0.0, longitude: 0.0));
}
