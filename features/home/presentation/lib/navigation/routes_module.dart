import 'package:features_home_presentation/widgets/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RoutesModule extends Module {
  static const path = '/';

  @override
  List<ModularRoute> get routes => [
    ChildRoute(path, child: (context, args) => const HomePage())
  ];
}
