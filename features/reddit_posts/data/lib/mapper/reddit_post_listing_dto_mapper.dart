import 'package:common_presentation/data/mapper.dart';
import 'package:features_reddit_posts_data/data/reddit_post_listing_dto.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';

class RedditPostListingDTOMapper extends Mapper<List<RedditPostListingDTO>, PostModel> {
  @override
  PostModel map(List<RedditPostListingDTO> input) {
    var post = input[0].data?.children?[0].data;
    var comments = input[1]
        .data
        ?.children
        ?.map((e) => PostModel(
              null,
              e.data?.author,
              e.data?.subreddit,
              e.data?.thumbnail,
              e.data?.body,
              null,
            ))
        .toList();
    return PostModel(
      null,
      post?.author,
      post?.subreddit,
      post?.thumbnail,
      post?.title,
      comments,
    );
  }
}
