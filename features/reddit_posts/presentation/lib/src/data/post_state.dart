class PostItemState {
  final String permalink;
  final String author;
  final String category;
  final Uri? icon;
  final String title;
  final Iterable<PostItemState>? comments;

  bool get isComment => comments?.isEmpty ?? true;

  PostItemState(this.permalink, this.author, this.category, this.icon, this.title, this.comments);
}
