import 'package:features_home_presentation/navigation/routes_module.dart' as home;
import 'package:features_reddit_posts_presentation/di/presentation_module.dart' as reddit_posts;
import 'package:features_reddit_posts_presentation/navigation/routes_module.dart' as reddit_posts;
import 'package:features_weather_data/di/data_module.dart' as weather;
import 'package:features_weather_domain/di/domain_module.dart' as weather;
import 'package:features_weather_presentation/di/presentation_module.dart' as weather;
import 'package:features_weather_presentation/navigation/routes_module.dart' as weather;
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        weather.DataModule(),
        weather.DomainModule(),
        weather.PresentationModule(),
        reddit_posts.PresentationModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(home.RoutesModule.path, module: home.RoutesModule()),
        ModuleRoute(weather.RoutesModule.path, module: weather.RoutesModule()),
        ModuleRoute(reddit_posts.RoutesModule.path, module: reddit_posts.RoutesModule()),
      ];
}
