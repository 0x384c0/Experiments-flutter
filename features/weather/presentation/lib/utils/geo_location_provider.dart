import 'package:features_weather_presentation/data/location_state.dart';
import 'package:features_weather_presentation/utils/geo_location.dart';

abstract class GeoLocationProvider {
  Future<LocationState> getLocation();
}

class GeoLocationProviderImpl implements GeoLocationProvider {
  @override
  Future<LocationState> getLocation() => GeoLocation.getPosition().then((value) => LocationState.fromPosition(value));
}
