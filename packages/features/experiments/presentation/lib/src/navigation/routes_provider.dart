import 'package:auto_route/auto_route.dart';
import 'package:features_experiments_presentation/src/navigation/router.gr.dart';
import 'package:injectable/injectable.dart';

/// Navigation for feature
abstract class ExperimentsRoutesProvider {
  PageRouteInfo rootRoute();

  PageInfo rootPage();
}

/// Private implementation of navigation
@Injectable(as: ExperimentsRoutesProvider)
class RoutesProviderImpl implements ExperimentsRoutesProvider {
  @override
  rootRoute() => const FlutterLayoutRoute();

  @override
  PageInfo rootPage() => FlutterLayoutRoute.page;
}
