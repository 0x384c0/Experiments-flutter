import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class WeatherRouter extends RootStackRouter {
  @override
  List<AutoRoute> routes = [WeatherRoute.page, ForecastDetailsRoute.page].map((page) => AutoRoute(page: page)).toList();
}
