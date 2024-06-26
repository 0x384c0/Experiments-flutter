import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/extensions/string.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

import '../data/reddit_post_listing_dto.dart';

class RedditPostListingDTOMapper extends Mapper<Map<String, Iterable<RedditPostListingDTO>>, PostModel> {
  @override
  map(input) {
    var permalink = input.keys.first;
    var dto = input.values.first;
    var post = dto.elementAt(0).data?.children?[0].data;
    var comments = dto.elementAt(1).data?.children?.map((e) => PostModel(
          null,
          e.data?.author,
          e.data?.subreddit,
          e.data?.thumbnail?.parseUri(),
          e.data?.body,
          null,
          null,
        ));
    return PostModel(
      permalink,
      post?.author,
      post?.subreddit,
      post?.thumbnail?.parseUri(),
      post?.title,
      comments,
      dto.elementAt(0).data?.after,
    );
  }
}
