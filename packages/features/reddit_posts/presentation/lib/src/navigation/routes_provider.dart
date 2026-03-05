import 'package:auto_route/auto_route.dart';
import 'package:features_reddit_posts_presentation/src/navigation/router.gr.dart';
import 'package:injectable/injectable.dart';

/// Navigation for weather feature
abstract class PostsRoutesProvider {
  PageRouteInfo rootRoute();

  PageInfo rootPage();
}

/// Private implementation if weather navigation
@Injectable(as: PostsRoutesProvider)
class RoutesProviderImpl implements PostsRoutesProvider {
  @override
  rootRoute() => const PostsHomeRoute();

  @override
  PageInfo rootPage() => PostsHomeRoute.page;
}
