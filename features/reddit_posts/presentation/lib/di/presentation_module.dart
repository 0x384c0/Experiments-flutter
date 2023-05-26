import 'package:flutter_modular/flutter_modular.dart';
import '../navigation/navigator.dart';

class PresentationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Navigator>(
          (i) => NavigatorImpl(),
          export: true,
        ),
      ];
}
