import 'package:common_presentation/data/mapper.dart';
import 'package:dio/dio.dart';
import 'package:features_reddit_posts_data/api/reddit_api.dart';
import 'package:features_reddit_posts_data/data/reddit_post_listing_dto.dart';
import 'package:features_reddit_posts_data/data/reddit_posts_response_dto.dart';
import 'package:features_reddit_posts_data/mapper/reddit_post_listing_dto_mapper.dart';
import 'package:features_reddit_posts_data/mapper/reddit_posts_response_dto_mapper.dart';
import 'package:features_reddit_posts_data/repository/remote_repository.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_domain/repository/remote_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DataModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Mapper<RedditPostsResponseDTO, Iterable<PostModel>>>(
          (i) => RedditPostsResponseDTOMapper(),
          export: true,
        ),
        Bind<Mapper<Map<String, Iterable<RedditPostListingDTO>>, PostModel>>(
          (i) => RedditPostListingDTOMapper(),
          export: true,
        ),
        Bind<RedditApi>(
          (i) => RedditApi(Dio()),
          export: true,
        ),
        Bind<RemoteRepository>(
          (i) => RemoteRepositoryImpl(i(), i(), i()),
          export: true,
        ),
      ];
}