import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_data/src/db/posts_database.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

typedef PostsModelToEntityMapper = Mapper<(PostsModel, int), (PostsEntityData, Iterable<PostEntityData>)>;

class PostsModelToEntityMapperImpl extends PostsModelToEntityMapper {
  @override
  map(input) => (
        PostsEntityData(
          id: input.$2,
          createdAt: DateTime.now(),
          after: input.$1.after,
        ),
        input.$1.posts?.map(
              (model) => PostEntityData(
                id: model.permalink.hashCode,
                postsEntityId: input.$2,
                permalink: model.permalink,
                author: model.author,
                category: model.category,
                icon: model.icon?.toString(),
                title: model.title,
                after: model.after,
                moreParentId: model.moreModel?.parentId,
                moreChildren: model.moreModel?.children.join(","),
              ),
            ) ??
            []
      );
}
