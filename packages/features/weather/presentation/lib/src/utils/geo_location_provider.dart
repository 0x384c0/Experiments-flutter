import 'package:features_weather_presentation/src/data/location_state.dart';
import 'package:injectable/injectable.dart';

import 'geo_location.dart';

abstract class GeoLocationProvider {
  Future<LocationState> getLocation();
}

@Injectable(as: GeoLocationProvider)
class GeoLocationProviderImpl implements GeoLocationProvider {
  @override
  Future<LocationState> getLocation() => GeoLocation.getPosition().then((value) => LocationState.fromPosition(value));
}

// TODO: provide for emulator
class MockGeoLocationProviderImpl implements GeoLocationProvider {
  @override
  Future<LocationState> getLocation() async => const LocationState(latitude: 40.7128, longitude: 74.0060);
}
