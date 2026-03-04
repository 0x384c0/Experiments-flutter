import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class FirebaseChatRouter extends RootStackRouter {
  @override
  List<AutoRoute> routes = [
    FirebaseAuthRoute.page,
    FirebaseChatRoute.page,
  ].map((page) => AutoRoute(page: page)).toList();
}
