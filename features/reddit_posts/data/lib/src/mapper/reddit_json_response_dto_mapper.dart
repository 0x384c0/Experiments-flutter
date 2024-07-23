import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_data/src/data/reddit_json_response_dto.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

class RedditJsonResponseDTOMapper extends Mapper<RedditJsonResponseDTO, Iterable<PostModel>> {
  @override
  Iterable<PostModel> map(RedditJsonResponseDTO input) =>
      input.json?.data?.things?.map((e) => PostModel(
            null,
            e.data?.author,
            e.data?.subreddit,
            null,
            e.data?.title,
            null,
            null,
            null,
          )) ??
      [];
}
