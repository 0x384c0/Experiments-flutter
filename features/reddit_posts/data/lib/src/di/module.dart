import 'package:common_data/mapper/error_dto_mapper.dart';
import 'package:common_domain/data/error_model.dart';
import 'package:common_domain/mapper/mapper.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:features_reddit_posts_data/src/api/reddit_api.dart';
import 'package:features_reddit_posts_data/src/data/reddit_json_response_dto.dart';
import 'package:features_reddit_posts_data/src/data/reddit_post_listing_dto.dart';
import 'package:features_reddit_posts_data/src/data/reddit_posts_response_dto.dart';
import 'package:features_reddit_posts_data/src/mapper/posts_entity_to_model_mapper.dart';
import 'package:features_reddit_posts_data/src/mapper/posts_model_to_entity_mapper.dart';
import 'package:features_reddit_posts_data/src/mapper/reddit_json_response_dto_mapper.dart';
import 'package:features_reddit_posts_data/src/mapper/reddit_post_listing_dto_mapper.dart';
import 'package:features_reddit_posts_data/src/mapper/reddit_posts_response_dto_mapper.dart';
import 'package:features_reddit_posts_data/src/repository/local_repository.dart';
import 'package:features_reddit_posts_data/src/repository/remote_repository.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostsDataModule extends Module {
  @override
  void binds(Injector i) {
    i.add<Mapper<dynamic, ErrorModel>>(ErrorDtoMapper.new);
    i.add<Mapper<RedditPostsResponseDTO, PostsModel>>(RedditPostsResponseDTOMapper.new);
    i.add<Mapper<Map<String, Iterable<RedditPostListingDTO>>, PostModel>>(RedditPostListingDTOMapper.new);
    i.add<Mapper<RedditJsonResponseDTO, Iterable<PostModel>>>(RedditJsonResponseDTOMapper.new);
    i.add<PostsEntityToModelMapper>(PostsEntityToModelMapperImpl.new);
    i.add<PostsModelToEntityMapper>(PostsModelToEntityMapperImpl.new);
    i.add(_provideDio);
    i.add(RedditApi.new);
  }

  @override
  exportedBinds(Injector i) {
    i.add<PostsRemoteRepository>(RemoteRepositoryImpl.new);
    i.addSingleton<PostsLocalRepository>(LocalRepositoryImpl.new);
  }

  Dio _provideDio() {
    final dio = Dio();
    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    return dio;
  }
}
