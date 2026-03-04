import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class FormsRouter extends RootStackRouter {
  @override
  List<AutoRoute> routes = [
    FormsRoute.page,
    FormzzValidationRoute.page,
    MaterialValidationRoute.page,
  ].map((page) => AutoRoute(page: page)).toList();
}
