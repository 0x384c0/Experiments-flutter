import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class WebViewRouter extends RootStackRouter {
  @override
  List<AutoRoute> routes = [
    WebViewsRoute.page,
    EmbeddedWebViewRoute.page,
    WebViewRoute.page,
  ].map((page) => AutoRoute(page: page)).toList();
}
