import 'package:common_domain/mapper/mapper.dart';
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

class PostsDataModule extends Module {
  @override
  void binds(Injector i) {
    i.add<Mapper<RedditPostsResponseDTO, Iterable<PostModel>>>(RedditPostsResponseDTOMapper.new);
    i.add<Mapper<Map<String, Iterable<RedditPostListingDTO>>, PostModel>>(RedditPostListingDTOMapper.new);
    i.add<RedditApi>(() => RedditApi(Dio()));
  }

  @override
  exportedBinds(Injector i) {
    i.add<PostsRemoteRepository>(RemoteRepositoryImpl.new);
  }
}
