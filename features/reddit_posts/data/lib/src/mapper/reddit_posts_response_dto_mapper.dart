import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/extensions/string.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

import '../data/reddit_posts_response_dto.dart';

class RedditPostsResponseDTOMapper extends Mapper<RedditPostsResponseDTO, PostsModel> {
  @override
  map(RedditPostsResponseDTO input) {
    final posts = input.data?.children?.map((e) {
          return PostModel(
            e.data?.permalink,
            e.data?.author,
            e.data?.subreddit,
            e.data?.thumbnail?.parseUri(),
            e.data?.title,
            null,
            null,
          );
        }) ??
        [];

    return PostsModel(posts, input.data?.after);
  }
}
