import 'package:domain/data/location_model.dart';
import 'package:geolocator/geolocator.dart';

class LocationState implements LocationModel {
  @override
  final double latitude;

  @override
  final double longitude;

  const LocationState({
    required this.latitude,
    required this.longitude,
  });

  LocationState.fromPosition(Position position)
      : latitude = position.latitude,
        longitude = position.longitude;
}
