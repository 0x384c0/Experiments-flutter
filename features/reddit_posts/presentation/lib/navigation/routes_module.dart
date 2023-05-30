import 'package:features_reddit_posts_presentation/widgets/posts_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RoutesModule extends Module {
  static const path = 'posts';

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const PostsPage()),
      ];
}
