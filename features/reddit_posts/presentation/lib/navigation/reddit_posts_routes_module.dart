import 'package:features_reddit_posts_presentation/widgets/posts_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RedditPostsRoutesModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const PostsPage()),
  ];
}
