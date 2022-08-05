import 'package:data/di/data_module.dart';
import 'package:domain/di/domain_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:presentation/di/presentation_module.dart';
import 'package:presentation/navigation/presentation_routes_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        DataModule(),
        DomainModule(),
        PresentationModule(),
      ];

  @override
  List<ModularRoute> get routes => [ModuleRoute('/', module: PresentationRoutesModule())];
}
