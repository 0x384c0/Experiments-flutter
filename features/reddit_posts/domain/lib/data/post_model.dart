class PostModel {
  final String? permalink;
  final String? author;
  final String? category;
  final String? icon;
  final String? title;
  final Iterable<PostModel>? comments;

  PostModel(this.permalink, this.author, this.category, this.icon, this.title, this.comments);
}
