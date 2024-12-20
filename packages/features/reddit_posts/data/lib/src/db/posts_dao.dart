import 'package:drift/drift.dart';
import 'package:features_reddit_posts_data/src/data/entity/posts_entity.dart';
import 'package:features_reddit_posts_data/src/db/posts_database.dart';

part 'posts_dao.g.dart';

@DriftAccessor(tables: [PostsEntity, PostEntity, PostComment])
class PostsDao extends DatabaseAccessor<PostsDatabase> with _$PostsDaoMixin {
  PostsDao(super.db);

  Future<PostsEntityData?> getPostsEntityForId(int id) =>
      (select(postsEntity)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future insertPostsEntity(PostsEntityData data) => into(postsEntity).insert(data, mode: InsertMode.insertOrReplace);

  Future<List<PostEntityData>> getPostEntityForPostsEntity(PostsEntityData data) =>
      (select(postEntity)..where((tbl) => tbl.postsEntityId.equals(data.id))).get();

  Future insertPostEntities(Iterable<PostEntityData> data) =>
      batch((batch) => batch.insertAll(postEntity, data, mode: InsertMode.insertOrReplace));

  Future deleteAll() async {
    await customStatement('PRAGMA foreign_keys = OFF');
    try {
      transaction(() async {
        for (final table in attachedDatabase.allTables) {
          await delete(table).go();
        }
      });
    } finally {
      await customStatement('PRAGMA foreign_keys = OFF');
    }
  }
}
