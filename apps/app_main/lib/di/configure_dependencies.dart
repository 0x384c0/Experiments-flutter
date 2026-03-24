import 'package:common_data/di/init_micro_package.module.dart';
import 'package:features_experiments_presentation/features_experiments_presentation.dart';
import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_reddit_posts_data/features_reddit_posts_data.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';
import 'package:features_stackoverflow_presentation/features_stackoverflow_presentation.dart';
import 'package:features_timelapse_presentation/features_timelapse_presentation.dart';
import 'package:features_weather_data/features_weather_data.dart';
import 'package:features_weather_domain/features_weather_domain.dart';
import 'package:features_weather_presentation/features_weather_presentation.dart';
import 'package:features_webview_presentation/features_webview_presentation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'configure_dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
  asExtension: true,
  externalPackageModulesBefore: [
    ExternalModule(CommonDataPackageModule),
    ExternalModule(FeaturesStackoverflowPresentationPackageModule),
    ExternalModule(FeaturesExperimentsPresentationPackageModule),
    ExternalModule(FeaturesFormsPresentationPackageModule),
    ExternalModule(FeaturesWebviewPresentationPackageModule),
    ExternalModule(FeaturesWeatherDomainPackageModule),
    ExternalModule(FeaturesWeatherDataPackageModule),
    ExternalModule(FeaturesWeatherPresentationPackageModule),
    ExternalModule(FeaturesRedditPostsDomainPackageModule),
    ExternalModule(FeaturesRedditPostsDataPackageModule),
    ExternalModule(FeaturesRedditPostsPresentationPackageModule),
    ExternalModule(FeaturesTimelapsePresentationPackageModule),
  ],
)
void configureDependencies() => getIt.init();
