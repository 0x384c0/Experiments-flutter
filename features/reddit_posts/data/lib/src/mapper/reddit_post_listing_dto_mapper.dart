import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/extensions/string.dart';
import 'package:features_reddit_posts_data/src/data/reddit_post_listing_child_dto.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

import '../data/reddit_post_listing_dto.dart';

class RedditPostListingDTOMapper extends Mapper<Map<String, Iterable<RedditPostListingDTO>>, PostModel> {
  @override
  map(input) {
    //TODO: get more model
    var permalink = input.keys.first;
    var dto = input.values.first;
    var post = dto.elementAt(0).data?.children?[0].data;
    var comments = dto.elementAt(1).data?.children?.where(_isComment).map((e) => PostModel(
          null,
          e.data?.author,
          e.data?.subreddit,
          e.data?.thumbnail?.parseUri(),
          e.data?.body,
          null,
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
      _dataToMoreModel(dto.elementAt(1).data?.children?.firstWhere(_isMore)),
    );
  }

  bool _isComment(RedditPostListingChildDTO child) => child.kind == "t1";

  bool _isMore(RedditPostListingChildDTO child) => child.kind == "more";

  _dataToMoreModel(RedditPostListingChildDTO? child) => child?.data != null
      ? MoreModel(
          child!.data!.id!,
          child.data!.children!,
        )
      : null;
}
