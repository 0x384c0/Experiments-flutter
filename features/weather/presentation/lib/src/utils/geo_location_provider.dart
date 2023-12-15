import '../data/location_state.dart';
import '../utils/geo_location.dart';

abstract class GeoLocationProvider {
  Future<LocationState> getLocation();
}

class GeoLocationProviderImpl implements GeoLocationProvider {
  @override
  Future<LocationState> getLocation() => GeoLocation.getPosition().then((value) => LocationState.fromPosition(value));
}
