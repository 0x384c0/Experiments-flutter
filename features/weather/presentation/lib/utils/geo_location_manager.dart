import 'package:features_weather_presentation/data/location_state.dart';
import 'package:features_weather_presentation/utils/geo_location.dart';

abstract class GeoLocationManager {
  Future<LocationState> getLocation();
}

class GeoLocationManagerImpl implements GeoLocationManager {
  @override
  Future<LocationState> getLocation() => GeoLocation.getPosition().then((value) => LocationState.fromPosition(value));
}
