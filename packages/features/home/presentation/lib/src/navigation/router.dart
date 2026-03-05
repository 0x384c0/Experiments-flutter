import 'package:auto_route/auto_route.dart';
import 'package:features_experiments_presentation/features_experiments_presentation.dart';
import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_home_presentation/src/data/route_info_provider.dart';
import 'package:features_home_presentation/src/data/selected_page_state.dart';
import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';
import 'package:features_stackoverflow_presentation/features_stackoverflow_presentation.dart';
import 'package:features_weather_presentation/features_weather_presentation.dart';
import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:get_it/get_it.dart';

import 'router.gr.dart';

List<RouteInfoProvider> getHomeChildren() {
  final redditRoutesProvider = GetIt.instance.get<PostsRoutesProvider>();
  final weatherRoutesProvider = GetIt.instance.get<WeatherRoutesProvider>();
  final formsRoutesProvider = GetIt.instance.get<FormsRoutesProvider>();
  final webViewRoutesProvider = GetIt.instance.get<WebViewRoutesProvider>();
  final experimentsRoutesProvider = GetIt.instance.get<ExperimentsRoutesProvider>();
  final stackoverflowRoutesProvider = GetIt.instance.get<StackOverflowRoutesProvider>();
  return [
    // first - initial route
    RouteInfoProvider(
      getPageInfo: formsRoutesProvider.rootPage,
      getRouteInfo: formsRoutesProvider.rootRoute,
      selectedPageState: SelectedPageState.forms,
    ),
    RouteInfoProvider(
      getPageInfo: redditRoutesProvider.rootPage,
      getRouteInfo: redditRoutesProvider.rootRoute,
      selectedPageState: SelectedPageState.posts,
    ),
    RouteInfoProvider(
      getPageInfo: weatherRoutesProvider.rootPage,
      getRouteInfo: weatherRoutesProvider.rootRoute,
      selectedPageState: SelectedPageState.weather,
    ),
    RouteInfoProvider(
      getPageInfo: webViewRoutesProvider.rootPage,
      getRouteInfo: webViewRoutesProvider.rootRoute,
      selectedPageState: SelectedPageState.webView,
    ),
    RouteInfoProvider(
      getPageInfo: experimentsRoutesProvider.rootPage,
      getRouteInfo: experimentsRoutesProvider.rootRoute,
      selectedPageState: SelectedPageState.experiments,
    ),
    RouteInfoProvider(
      getPageInfo: stackoverflowRoutesProvider.rootPage,
      getRouteInfo: stackoverflowRoutesProvider.rootRoute,
      selectedPageState: SelectedPageState.stackoverflow,
    ),
    RouteInfoProvider(
      getPageInfo: () => OthersRoute.page,
      getRouteInfo: OthersRoute.new,
      selectedPageState: SelectedPageState.others,
    ),
  ];
}

@AutoRouterConfig()
class HomeRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
      children: getHomeChildren().map((info) => AutoRoute(page: info.getPageInfo())).toList(),
    ),
  ];
}
