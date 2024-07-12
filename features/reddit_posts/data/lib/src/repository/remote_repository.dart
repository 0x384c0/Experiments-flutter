import 'package:common_domain/extensions/future.dart';
import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_data/src/api/reddit_api.dart';
import 'package:features_reddit_posts_data/src/data/reddit_json_response_dto.dart';
import 'package:features_reddit_posts_data/src/data/reddit_post_listing_dto.dart';
import 'package:features_reddit_posts_data/src/data/reddit_posts_response_dto.dart';
import 'package:features_reddit_posts_data/src/data/reddit_posts_sort_dto.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

class RemoteRepositoryImpl implements PostsRemoteRepository {
  static const String _defaultSubreddit = "all";
  static const int _pageLimit = 25;

  RemoteRepositoryImpl(
    this._redditApi,
    this._redditPostsResponseDTOMapper,
    this._redditPostListingDTOMapper,
    this._redditJsonResponseDTOMapper,
    this._errorDtoMapper,
  );

  final RedditApi _redditApi;
  final Mapper<RedditPostsResponseDTO, PostsModel> _redditPostsResponseDTOMapper;
  final Mapper<Map<String, Iterable<RedditPostListingDTO>>, PostModel> _redditPostListingDTOMapper;
  final Mapper<RedditJsonResponseDTO, PostModel> _redditJsonResponseDTOMapper;
  final Mapper<dynamic, ErrorModel> _errorDtoMapper;

  @override
  Future<PostsModel> getPosts({
    String? after,
  }) {
    return _redditApi
        .getPosts(
          subreddit: _defaultSubreddit,
          sort: RedditPostsSortDTO.top,
          limit: _pageLimit,
          after: after,
        )
        .then(_redditPostsResponseDTOMapper.map)
        .mapError(_errorDtoMapper.map);
  }

  @override
  Future<PostModel> getPost({
    required String permalink,
  }) =>
      _redditApi
          .getPost(
            permalink: permalink,
          )
          .then((dto) => _redditPostListingDTOMapper.map({permalink: dto}))
          .mapError(_errorDtoMapper.map);

  @override
  Future<PostModel> getMoreChildren({
    required String apiType,
    required String linkId,
    required Iterable<String> children,
  }) =>
      _redditApi
          .getMoreChildren(
            apiType: apiType,
            linkId: linkId,
            children: children.join(","),
          )
          .then(_redditJsonResponseDTOMapper.map)
          .mapError(_errorDtoMapper.map);
}
