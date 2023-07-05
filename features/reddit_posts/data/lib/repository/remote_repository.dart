library data;

import 'package:features_reddit_posts_data/api/reddit_api.dart';
import 'package:features_reddit_posts_data/data/reddit_posts_sort_dto.dart';
import 'package:features_reddit_posts_data/mapper/reddit_posts_response_dto_mapper.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_domain/repository/remote_repository.dart';

class RemoteRepositoryImpl implements RemoteRepository {
  RemoteRepositoryImpl(this.redditApi, this.redditPostsResponseDTOMapper);

  RedditApi redditApi;
  RedditPostsResponseDTOMapper redditPostsResponseDTOMapper;

  @override
  Future<List<PostModel>> getPosts() {
    return redditApi
        .getCurrent("all", RedditPostsSortDTO.top)
      .then(redditPostsResponseDTOMapper.map);
  }
}