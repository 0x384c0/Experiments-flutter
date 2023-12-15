import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/extensions/string.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';

import '../data/reddit_posts_response_dto.dart';

class RedditPostsResponseDTOMapper extends Mapper<RedditPostsResponseDTO, Iterable<PostModel>> {
  @override
  Iterable<PostModel> map(RedditPostsResponseDTO input) {
    return input.data?.children?.map((e) {
          return PostModel(
            e.data?.permalink,
            e.data?.author,
            e.data?.subreddit,
            e.data?.thumbnail?.parseUri(),
            e.data?.title,
            null,
          );
        }) ??
        [];
  }
}
