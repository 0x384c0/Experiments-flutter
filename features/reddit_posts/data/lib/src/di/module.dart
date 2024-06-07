import 'package:common_domain/mapper/mapper.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../api/reddit_api.dart';
import '../data/reddit_post_listing_dto.dart';
import '../data/reddit_posts_response_dto.dart';
import '../mapper/reddit_post_listing_dto_mapper.dart';
import '../mapper/reddit_posts_response_dto_mapper.dart';
import '../repository/remote_repository.dart';

class PostsDataModule extends Module {
  @override
  void binds(Injector i) {
    i.add<Mapper<RedditPostsResponseDTO, PostsModel>>(RedditPostsResponseDTOMapper.new);
    i.add<Mapper<Map<String, Iterable<RedditPostListingDTO>>, PostModel>>(RedditPostListingDTOMapper.new);
    i.add(_provideDio);
    i.add(RedditApi.new);
  }

  @override
  exportedBinds(Injector i) {
    i.add<PostsRemoteRepository>(RemoteRepositoryImpl.new);
  }

  Dio _provideDio() {
    final dio = Dio();
    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    return dio;
  }
}
