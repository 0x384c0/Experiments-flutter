import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:features_stackoverflow_presentation/features_stackoverflow_presentation.dart';

import 'configure_dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
  asExtension: true,
  externalPackageModulesBefore: [
    ExternalModule(FeaturesStackoverflowPresentationPackageModule),
  ],
)
void configureDependencies() => getIt.init();