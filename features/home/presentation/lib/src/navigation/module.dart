import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/home.dart';

class HomeRoutesModule extends Module {
  static const path = '/';

  @override
  void routes(r) {
    r.child(path, child: (context) => const HomePage());
  }
}
