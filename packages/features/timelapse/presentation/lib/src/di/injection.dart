import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

@InjectableInit()
void configureTimelapseDependencies(GetIt getIt) => getIt.init();
