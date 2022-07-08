import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
//modules
import 'package:domain/interactor/interactor.dart';
import 'package:data/datasource/remote_data_source.dart';
//local
import 'weather_observer.dart';
import 'weather_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBlocOverrides.runZoned(
    () => runApp(WeatherApp(DomainModule.provideWeatherInteractor(DataModule.provideRemoteDataSource()))),//TODO: use dart_modular for DI
    blocObserver: WeatherObserver(),
    storage: await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
    ),
  );
  // return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}