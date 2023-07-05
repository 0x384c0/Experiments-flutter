import 'package:common_presentation/data/mapper.dart';
import 'package:features_reddit_posts_data/data/reddit_posts_response_dto.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';

class RedditPostsResponseDTOMapper extends Mapper<RedditPostsResponseDTO, List<PostModel>> {
  @override
  List<PostModel> map(RedditPostsResponseDTO input) {
    return input.data?.children
            ?.map((e) => PostModel(
                  e.data?.permalink,
                  e.data?.author,
                  e.data?.subreddit,
                  e.data?.icon,
                  e.data?.title,
                ))
            .toList() ??
        [];
  }
}
