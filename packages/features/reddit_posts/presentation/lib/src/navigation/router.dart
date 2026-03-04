import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class PostsRouter extends RootStackRouter {
  @override
  List<AutoRoute> routes = [
    PostsHomeRoute.page,
    PostDetailsRoute.page,
    PostsRoute.page,
    LocalFirstPostsRoute.page,
  ].map((page) => AutoRoute(page: page)).toList();
}
