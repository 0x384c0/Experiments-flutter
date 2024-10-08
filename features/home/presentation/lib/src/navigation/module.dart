import 'package:flutter_modular/flutter_modular.dart';

import '../screens/home_screen.dart';

class HomeRoutesModule extends Module {
  static const path = '/';

  @override
  void routes(r) {
    r.child(path, child: (context) => const HomeScreen());
  }
}
