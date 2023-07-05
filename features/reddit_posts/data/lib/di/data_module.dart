
import 'package:dio/dio.dart';
import 'package:features_reddit_posts_domain/repository/remote_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../api/reddit_api.dart';
import '../repository/remote_repository.dart';

class DataModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<RedditApi>(
          (i) => RedditApi(Dio()),
          export: true,
        ),
        Bind<RemoteRepository>(
          (i) => RemoteRepositoryImpl(i()),
          export: true,
        ),
      ];
}