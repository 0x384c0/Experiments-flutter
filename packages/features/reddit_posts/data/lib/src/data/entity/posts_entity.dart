import 'package:drift/drift.dart';

class PostsEntity extends Table {
  IntColumn get id => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();

  TextColumn get after => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PostEntity extends Table {
  IntColumn get id => integer()();

  IntColumn get postsEntityId => integer().nullable().references(PostsEntity, #id)();

  TextColumn get permalink => text().nullable()();

  TextColumn get author => text().nullable()();

  TextColumn get category => text().nullable()();

  TextColumn get icon => text().nullable()();

  TextColumn get title => text().nullable()();

  TextColumn get after => text().nullable()();

  TextColumn get moreParentId => text().nullable()();

  TextColumn get moreChildren => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PostComment extends PostEntity {
  IntColumn get postEntityId => integer().nullable().references(PostEntity, #id)();
}
