import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class StackOverflowRouter extends RootStackRouter {
  @override
  List<AutoRoute> routes = [AutoRoute(page: QuestionsRoute.page)];
}
