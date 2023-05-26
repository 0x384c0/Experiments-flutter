import 'package:features_home_presentation/navigation/home_routes_module.dart';
import 'package:features_reddit_posts_presentation/di/presentation_module.dart' as reddit_posts;
import 'package:features_reddit_posts_presentation/navigation/reddit_posts_routes_module.dart';
import 'package:features_weather_data/di/data_module.dart';
import 'package:features_weather_domain/di/domain_module.dart';
import 'package:features_weather_presentation/di/presentation_module.dart' as weather;
import 'package:features_weather_presentation/navigation/weather_routes_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        DataModule(),
        DomainModule(),
        weather.PresentationModule(),
        reddit_posts.PresentationModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeRoutesModule()),
        ModuleRoute(WeatherRoutesModule.path, module: WeatherRoutesModule()),
        ModuleRoute(RedditPostsRoutesModule.path, module: RedditPostsRoutesModule()),
      ];
}
