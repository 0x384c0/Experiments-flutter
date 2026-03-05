import 'package:auto_route/auto_route.dart';
import 'package:features_webview_presentation/src/navigation/router.gr.dart';
import 'package:injectable/injectable.dart';

/// Navigation for feature
abstract class WebViewRoutesProvider {
  PageRouteInfo rootRoute();

  PageInfo rootPage();
}

/// Private implementation of navigation
@Injectable(as: WebViewRoutesProvider)
class RoutesProviderImpl implements WebViewRoutesProvider {
  @override
  rootRoute() => const WebViewsRoute();

  @override
  PageInfo rootPage() => WebViewsRoute.page;
}
