import 'package:common_presentation/data/mapper.dart';
import 'package:dio/dio.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_domain/repository/remote_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../api/reddit_api.dart';
import '../data/reddit_posts_response_dto.dart';
import '../mapper/reddit_posts_response_dto_mapper.dart';
import '../repository/remote_repository.dart';

class DataModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Mapper<RedditPostsResponseDTO, List<PostModel>>>(
          (i) => RedditPostsResponseDTOMapper(),
          export: true,
        ),
        Bind<RedditApi>(
          (i) => RedditApi(Dio()),
          export: true,
        ),
        Bind<RemoteRepository>(
          (i) => RemoteRepositoryImpl(i(), i()),
          export: true,
        ),
      ];
}