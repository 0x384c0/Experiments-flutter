import 'package:auto_route/auto_route.dart';
import 'package:features_weather_presentation/src/navigation/router.gr.dart';
import 'package:injectable/injectable.dart';

/// Navigation for weather feature
abstract class WeatherRoutesProvider {
  PageRouteInfo rootRoute();

  PageInfo rootPage();
}

/// Private implementation if weather navigation
@Injectable(as: WeatherRoutesProvider)
class RoutesProviderImpl implements WeatherRoutesProvider {
  @override
  rootRoute() => const WeatherRoute();

  @override
  PageInfo rootPage() => WeatherRoute.page;
}
