import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_data/src/db/posts_database.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

typedef PostsEntityToModelMapper
    = Mapper<(PostsEntityData postsEntity, Iterable<PostEntityData> postEntities), PostsModel>;

class PostsEntityToModelMapperImpl extends PostsEntityToModelMapper {
  @override
  map(input) => PostsModel(
        input.$2.map((entity) => PostModel(
              permalink: entity.permalink,
              author: entity.author,
              category: entity.category,
              icon: Uri.tryParse(entity.icon ?? ""),
              title: entity.title,
              after: entity.after,
              moreModel: entity.moreParentId != null
                  ? MoreModel(
                      parentId: entity.moreParentId!,
                      children: entity.moreChildren?.split(",") ?? [],
                    )
                  : null,
            )),
        input.$1.after,
      );
}
