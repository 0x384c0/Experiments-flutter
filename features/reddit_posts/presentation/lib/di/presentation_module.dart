import 'package:flutter_modular/flutter_modular.dart';
import '../navigation/reddit_posts_navigator.dart';

class PresentationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<RedditPostsNavigator>(
          (i) => RedditPostsNavigatorImpl(),
          export: true,
        ),
      ];
}
