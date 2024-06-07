class PostModel {
  final String? permalink;
  final String? author;
  final String? category;
  final Uri? icon;
  final String? title;
  final Iterable<PostModel>? comments;
  final String? after;

  PostModel(this.permalink, this.author, this.category, this.icon, this.title, this.comments, this.after);
}

class PostsModel {
  final Iterable<PostModel>? posts;
  final String? after;

  PostsModel(this.posts, this.after);
}
