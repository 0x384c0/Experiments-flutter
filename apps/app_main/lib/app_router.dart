import 'package:auto_route/auto_route.dart';
import 'package:features_experiments_presentation/features_experiments_presentation.dart';
import 'package:features_firebase_chat_presentation/features_firebase_chat_presentation.dart';
import 'package:features_forms_presentation/features_forms_presentation.dart';
import 'package:features_home_presentation/features_home_presentation.dart';
import 'package:features_reddit_posts_presentation/features_reddit_posts_presentation.dart';
import 'package:features_stackoverflow_presentation/features_stackoverflow_presentation.dart';
import 'package:features_weather_presentation/features_weather_presentation.dart';
import 'package:features_webview_presentation/features_webview_presentation.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final _homeRouter = HomeRouter();
  final _experimentsRouter = ExperimentsRouter();
  final _postsRouter = PostsRouter();
  final _formsRouter = FormsRouter();
  final _firebaseChatRouter = FirebaseChatRouter();
  final _webviewRouter = WebViewRouter();
  final _weatherRouter = WeatherRouter();
  final _stackOverflowRouter = StackOverflowRouter();

  @override
  List<AutoRoute> get routes => [
    ..._homeRouter.routes,
    ..._experimentsRouter.routes,
    ..._postsRouter.routes,
    ..._formsRouter.routes,
    ..._firebaseChatRouter.routes,
    ..._webviewRouter.routes,
    ..._weatherRouter.routes,
    ..._stackOverflowRouter.routes,
  ];
}
