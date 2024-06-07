library data;

import 'package:common_domain/extensions/future.dart';
import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

import '../api/reddit_api.dart';
import '../data/reddit_post_listing_dto.dart';
import '../data/reddit_posts_response_dto.dart';
import '../data/reddit_posts_sort_dto.dart';

class RemoteRepositoryImpl implements PostsRemoteRepository {
  static const String _defaultSubreddit = "all";
  static const int _pageLimit = 25;

  RemoteRepositoryImpl(
      this.redditApi, this.redditPostsResponseDTOMapper, this.redditPostListingDTOMapper, this.errorDtoMapper);

  RedditApi redditApi;
  Mapper<RedditPostsResponseDTO, PostsModel> redditPostsResponseDTOMapper;
  Mapper<Map<String, Iterable<RedditPostListingDTO>>, PostModel> redditPostListingDTOMapper;
  Mapper<dynamic, ErrorModel> errorDtoMapper;

  @override
  Future<PostsModel> getPosts({
    String? after,
  }) {
    return redditApi
        .getPosts(
          subreddit: _defaultSubreddit,
          sort: RedditPostsSortDTO.top,
          limit: _pageLimit,
          after: after,
        )
        .then(redditPostsResponseDTOMapper.map)
        .mapError(errorDtoMapper.map);
  }

  @override
  Future<PostModel> getPost(String permalink) => redditApi
      .getPost(permalink)
      .then((dto) => redditPostListingDTOMapper.map({permalink: dto}))
      .mapError(errorDtoMapper.map);
}
