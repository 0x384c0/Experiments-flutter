import 'package:auto_route/auto_route.dart';
import 'package:features_timelapse_presentation/src/navigation/router.gr.dart';
import 'package:injectable/injectable.dart';

abstract class TimelapseRoutesProvider {
  PageRouteInfo rootRoute();
  PageInfo rootPage();
}

@Injectable(as: TimelapseRoutesProvider)
class RoutesProviderImpl implements TimelapseRoutesProvider {
  @override
  rootRoute() => const TimelapseRoute();

  @override
  PageInfo rootPage() => TimelapseRoute.page;
}
