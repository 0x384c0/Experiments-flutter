import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_data/src/data/reddit_json_response_dto.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

class RedditJsonResponseDTOMapper extends Mapper<RedditJsonResponseDTO, Iterable<PostModel>> {
  @override
  Iterable<PostModel> map(RedditJsonResponseDTO input) =>
      input.json?.data?.things?.where((e) => e.kind == "t1").map((e) => PostModel(
            author: e.data?.author,
            category: e.data?.subreddit,
            title: e.data?.body,
          )) ??
      [];
}
