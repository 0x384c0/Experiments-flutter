library interactor;

import 'package:domain/data/current_model.dart';
import 'package:domain/data/forecast_model.dart';
import 'package:domain/data/location_model.dart';
import 'package:domain/repository/remote_repository.dart';

abstract class WeatherInteractor {
  //TODO: unit tests
  Future<CurrentModel> getCurrent();

  Future<ForecastModel> getForecast(LocationModel location);

  Future<ForecastItemModel?> getForecastItem(LocationModel location, String dateEpoch);
}

class WeatherInteractorImpl extends WeatherInteractor {
  WeatherInteractorImpl(this.remoteRepository);

  late RemoteRepository remoteRepository;

  @override
  Future<CurrentModel> getCurrent() {
    return remoteRepository.getCurrent();
  }

  @override
  Future<ForecastModel> getForecast(LocationModel location) {
    return remoteRepository.getForecast(location);
  }

  @override
  Future<ForecastItemModel?> getForecastItem(LocationModel location, String dateEpoch) {
    return remoteRepository.getForecast(location)
        .then((value) => value.forecast?.firstWhere((element) => element.dateEpoch.toString() == dateEpoch));
  }
}
