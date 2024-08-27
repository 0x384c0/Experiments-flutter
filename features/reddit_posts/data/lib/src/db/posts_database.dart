import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:features_reddit_posts_data/src/data/entity/posts_entity.dart';

part 'posts_database.g.dart';

@DriftDatabase(tables: [PostsEntity, PostEntity, PostComment])
class PostsDatabase extends _$PostsDatabase {
  PostsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() => driftDatabase(name: 'posts_database');
}
