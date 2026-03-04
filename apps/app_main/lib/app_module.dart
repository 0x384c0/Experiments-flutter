import 'package:features_experiments_presentation/features_experiments_presentation.dart';
import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_reddit_posts_data/features_reddit_posts_data.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';
import 'package:features_stackoverflow_presentation/features_stackoverflow_presentation.dart';
import 'package:features_weather_data/features_weather_data.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:features_weather_presentation/features_weather_presentation.dart';
import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  final bool isRealDevice;

  AppModule({required this.isRealDevice});

  // class names for modules cannot be same
  @override
  List<Module> get imports => [
        PostsDomainModule([
          PostsPresentationModule(),
          PostsDataModule(),
        ]),
        WeatherDomainModule([
          WeatherPresentationModule(isRealDevice: isRealDevice),
          WeatherDataModule(),
        ]),
        FormsPresentationModule(),
        WebViewPresentationModule(),
        ExperimentsPresentationModule(),
        StackOverflowPresentationModule(),
      ];
}
