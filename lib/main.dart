import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/app_module.dart';
import 'package:weather_app/weather_app_view.dart';
import 'package:weather_app/weather_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBlocOverrides.runZoned(
    () => runApp(ModularApp(module: AppModule(), child: const WeatherAppView())),
    blocObserver: WeatherObserver(),
    storage: await HydratedStorage.build(
      storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
    ),
  );
}
