import 'package:features_reddit_posts_presentation/navigation/navigator.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PresentationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Navigator>(
          (i) => NavigatorImpl(),
          export: true,
        ),
      ];
}
