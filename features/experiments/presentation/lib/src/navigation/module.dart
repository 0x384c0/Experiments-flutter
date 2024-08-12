
import 'package:features_experiments_presentation/src/widgets/flutter_layout_page.dart';
import 'package:features_experiments_presentation/src/widgets/masonry_grid_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExperimentsRoutesModule extends Module {
  static const path = '/experiments';
  static const masonryGrid = '/masonry_grid';

  @override
  void routes(r) {
    r.child('/', child: (context) => FlutterLayoutPage());
    r.child(masonryGrid, child: (context) => const MasonryGridPage());
  }
}
