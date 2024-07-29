import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/extensions/string.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

import '../data/reddit_posts_response_dto.dart';

class RedditPostsResponseDTOMapper extends Mapper<RedditPostsResponseDTO, PostsModel> {
  @override
  map(RedditPostsResponseDTO input) {
    final posts = input.data?.children?.map((e) {
          return PostModel(
            permalink: e.data?.permalink,
            author: e.data?.author,
            category: e.data?.subreddit,
            icon: e.data?.thumbnail?.parseUri(),
            title: e.data?.title,
          );
        }) ??
        [];

    return PostsModel(posts, input.data?.after);
  }
}
