import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class ExperimentsRouter extends RootStackRouter {
  @override
  List<AutoRoute> routes = [
    FlutterLayoutRoute.page,
    MasonryGridRoute.page,
    WidgetsRoute.page,
  ].map((page) => AutoRoute(page: page)).toList();
}
