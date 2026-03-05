import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safe_device/safe_device.dart';

import 'app_view.dart';
import 'di/configure_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  var isRealDevice = true;

  try {
    isRealDevice = await SafeDevice.isRealDevice;
  } catch (_) {}

  configureDependencies();

  runApp(AppView());
}
