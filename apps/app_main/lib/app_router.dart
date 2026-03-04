import 'package:auto_route/auto_route.dart';
import 'package:features_experiments_presentation/features_experiments_presentation.dart';
import 'package:features_home_presentation/features_home_presentation.dart';
import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final _homeRouter = HomeRouter();
  final _experimentsRouter = ExperimentsRouter();
  final _postsRouter = PostsRouter();

  @override
  List<AutoRoute> get routes => [..._homeRouter.routes, ..._experimentsRouter.routes, ..._postsRouter.routes];
}
