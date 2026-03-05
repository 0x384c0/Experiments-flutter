import 'package:auto_route/auto_route.dart';
import 'package:features_stackoverflow_presentation/src/navigation/router.gr.dart';
import 'package:injectable/injectable.dart';

/// Navigation for stackoverflow feature
abstract class StackOverflowRoutesProvider {
  PageRouteInfo rootRoute();

  PageInfo rootPage();
}

/// Private implementation if stackoverflow navigation
@Injectable(as: StackOverflowRoutesProvider)
class RoutesProviderImpl implements StackOverflowRoutesProvider {
  @override
  rootRoute() => QuestionsRoute();

  @override
  PageInfo rootPage() => QuestionsRoute.page;
}
