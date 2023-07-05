import 'package:common_presentation/data/mapper.dart';
import 'package:common_presentation/extensions/string.dart';
import 'package:features_reddit_posts_data/data/reddit_post_listing_dto.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';

class RedditPostListingDTOMapper extends Mapper<Iterable<RedditPostListingDTO>, PostModel> {
  @override
  PostModel map(Iterable<RedditPostListingDTO> input) {
    var post = input.elementAt(0).data?.children?[0].data;
    var comments = input.elementAt(1).data?.children?.map((e) => PostModel(
          null,
          e.data?.author,
          e.data?.subreddit,
          e.data?.thumbnail?.parseUri(),
          e.data?.body,
          null,
        ));
    return PostModel(
      null,
      post?.author,
      post?.subreddit,
      post?.thumbnail?.parseUri(),
      post?.title,
      comments,
    );
  }
}
