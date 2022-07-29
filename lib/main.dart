import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

//modules
import 'package:domain/interactor/interactor.dart';
import 'package:data/datasource/remote_data_source.dart';
import 'package:presentation/navigation/weather_navigator.dart';
import 'package:presentation/weather_page.dart';
import 'package:weather_app/weather_app_view.dart';

//local
import 'weather_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBlocOverrides.runZoned(
    () => runApp(ModularApp(module: AppModule(), child: const WeatherAppView())),
    blocObserver: WeatherObserver(),
    storage: await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
    ),
  );
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<WeatherInteractor>((i) =>
            DomainModule.provideWeatherInteractor(
                DataModule.provideRemoteDataSource()))
      ];

  @override
  List<ModularRoute> get routes => getWeatherRoutes();
}
