import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/home.dart';

class RoutesModule extends Module {
  static const path = '/';

  @override
  List<ModularRoute> get routes => [
    ChildRoute(path, child: (context, args) => const HomePage())
  ];
}
