import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/home.dart';

class HomeRoutesModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const HomePage())
  ];
}
