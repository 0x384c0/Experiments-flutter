import 'package:features_home_presentation/navigation/routes_module.dart';
import 'package:features_reddit_posts_domain/di/domain_module.dart';
import 'package:features_reddit_posts_presentation/di/presentation_module.dart';
import 'package:features_reddit_posts_presentation/navigation/routes_module.dart';
import 'package:features_reddit_posts_data/di/data_module.dart';
import 'package:features_weather_data/di/data_module.dart';
import 'package:features_weather_domain/di/domain_module.dart';
import 'package:features_weather_presentation/di/presentation_module.dart';
import 'package:features_weather_presentation/navigation/routes_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {

  @override
  void routes(r) {
    r.module(HomeRoutesModule.path, module: HomeRoutesModule());
    r.module(RoutesModule.path, module: RoutesModule());
    r.module(WeatherRoutesModule.path, module: WeatherRoutesModule());
  }

  // class names for modules cannot be same
  @override
  List<Module> get imports => [
    PostsPresentationModule(),
    PostsDataModule(),
    PostsDomainModule(),
    WeatherPresentationModule(),
    WeatherDomainModule(),
    WeatherDataModule(),
  ];
}
