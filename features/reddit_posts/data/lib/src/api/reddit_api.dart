import 'package:dio/dio.dart';
import 'package:features_reddit_posts_data/src/data/reddit_json_response_dto.dart';
import '../data/reddit_post_listing_dto.dart';
import '../data/reddit_posts_response_dto.dart';
import '../data/reddit_posts_sort_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'reddit_api.g.dart';

@RestApi(baseUrl: "https://api.reddit.com")
abstract class RedditApi {
  factory RedditApi(Dio dio) = _RedditApi;

  @GET("/r/{subreddit}/{sort}")
  Future<RedditPostsResponseDTO> getPosts({
    @Path("subreddit") required String subreddit,
    @Path("sort") required RedditPostsSortDTO sort,
    @Query("limit") required int limit,
    @Query("after") required String? after,
  });

  @GET("{permalink}")
  Future<List<RedditPostListingDTO>> getPost({
    @Path("permalink") required String permalink,
  });

  @GET("/api/morechildren")
  Future<RedditJsonResponseDTO> getMoreChildren({
    @Query("api_type") required String apiType,
    @Query("link_id") required String linkId,
    @Query("children") required String children,
  });
}
