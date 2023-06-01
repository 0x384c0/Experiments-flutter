import 'package:dio/dio.dart';
import 'package:features_reddit_posts_data/data/reddit_posts_response_dto.dart';
import 'package:features_reddit_posts_data/data/reddit_posts_sort_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'reddit_api.g.dart';

@RestApi(baseUrl: "https://api.reddit.com")
abstract class RedditApi {
  factory RedditApi(Dio dio, {String baseUrl}) = _RedditApi;

  @GET("/r/{subreddit}/{sort}")
  Future<RedditPostsResponseDTO> getCurrent(
    @Path("subreddit") String subreddit,
    @Path("sort") RedditPostsSortDTO sort,
  );
}
