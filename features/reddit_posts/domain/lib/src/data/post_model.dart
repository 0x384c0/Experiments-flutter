import 'more_model.dart';

class PostModel {
  final String? permalink;
  final String? author;
  final String? category;
  final Uri? icon;
  final String? title;
  final Iterable<PostModel>? comments;
  final String? after;
  final MoreModel? moreModel;

  PostModel(
    this.permalink,
    this.author,
    this.category,
    this.icon,
    this.title,
    this.comments,
    this.after,
    this.moreModel,
  );
}

class PostsModel {
  final Iterable<PostModel>? posts;
  final String? after;

  PostsModel(
    this.posts,
    this.after,
  );
}
