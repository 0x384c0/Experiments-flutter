import 'package:data/di/data_module.dart';
import 'package:domain/di/domain_module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation/di/presentation_module.dart';
import 'package:presentation/navigation/presentation_routes_module.dart';
import 'package:weather_app/weather_app_view.dart';

import 'weather_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBlocOverrides.runZoned(
    () =>
        runApp(ModularApp(module: AppModule(), child: const WeatherAppView())),
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
  List<Module> get imports => [
        DataModule(),
        DomainModule(),
        PresentationModule(),
      ];

  @override
  List<ModularRoute> get routes =>
      [ModuleRoute('/', module: PresentationRoutesModule())];
}
