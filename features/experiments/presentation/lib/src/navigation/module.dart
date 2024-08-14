import 'package:features_experiments_presentation/src/widgets/flutter_layout_page.dart';
import 'package:features_experiments_presentation/src/widgets/masonry_grid_page.dart';
import 'package:features_experiments_presentation/src/widgets/widgets_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExperimentsRoutesModule extends Module {
  static const path = '/experiments';
  static const masonryGrid = '/masonry_grid';
  static const widgets = '/widgets';

  @override
  void routes(r) {
    r.child('/', child: (context) => const FlutterLayoutPage());
    r.child(masonryGrid, child: (context) => const MasonryGridPage());
    r.child(widgets, child: (context) => const WidgetsPage());
  }
}
