import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safe_device/safe_device.dart';

import 'app_module.dart';
import 'app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );

  var isRealDevice = true;

  try {
    isRealDevice = await SafeDevice.isRealDevice;
  } catch (_) {}

  runApp(
    ModularApp(
      module: AppModule(isRealDevice: isRealDevice),
      child: const AppView(),
    ),
  );
}
