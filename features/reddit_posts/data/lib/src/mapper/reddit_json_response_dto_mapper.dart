import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_data/src/data/reddit_json_response_dto.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

class RedditJsonResponseDTOMapper extends Mapper<RedditJsonResponseDTO, PostModel> {
  @override
  PostModel map(RedditJsonResponseDTO input) => throw UnimplementedError();
}
