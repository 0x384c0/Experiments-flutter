import 'package:features_home_presentation/widgets/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeRoutesModule extends Module {
  static const path = '/';

  @override
  void routes(r) {
    r.child(path, child: (context) => const HomePage());
  }
}
