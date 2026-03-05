import 'package:auto_route/auto_route.dart';
import 'package:features_forms_presentation/src/navigation/router.gr.dart';
import 'package:injectable/injectable.dart';

/// Navigation for feature
abstract class FormsRoutesProvider {
  PageRouteInfo rootRoute();

  PageInfo rootPage();
}

/// Private implementation of navigation
@Injectable(as: FormsRoutesProvider)
class RoutesProviderImpl implements FormsRoutesProvider {
  @override
  rootRoute() => const FormsRoute();

  @override
  PageInfo rootPage() => FormsRoute.page;
}
