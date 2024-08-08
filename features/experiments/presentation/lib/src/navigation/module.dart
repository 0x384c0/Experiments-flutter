
import 'package:features_experiments_presentation/src/widgets/flutter_layout_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExperimentsRoutesModule extends Module {
  static const path = '/experiments';

  @override
  void routes(r) {
    r.child('/', child: (context) => const FlutterLayoutPage());
  }
}
