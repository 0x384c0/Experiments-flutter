import 'package:features_weather_presentation/src/data/location_state.dart';
import 'package:injectable/injectable.dart';
import 'package:safe_device/safe_device.dart';

import 'geo_location.dart';

abstract class GeoLocationProvider {
  Future<LocationState> getLocation();
}

@Injectable(as: GeoLocationProvider)
class GeoLocationProviderImpl implements GeoLocationProvider {
  bool? _isRealDevice = null;

  @override
  Future<LocationState> getLocation() async {
    if (_isRealDevice == null) {
      try {
        _isRealDevice = await SafeDevice.isRealDevice;
      } catch (_) {}
    }
    return _isRealDevice == true
        ? GeoLocation.getPosition().then((value) => LocationState.fromPosition(value))
        : const LocationState(latitude: 40.7128, longitude: 74.0060);
  }
}
