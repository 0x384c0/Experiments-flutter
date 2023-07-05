abstract class PostsState {}

class PostsStateEmpty implements PostsState {}

class PostsStatePopulated implements PostsState {
  final Iterable<PostItemState> posts;

  PostsStatePopulated(this.posts);
}

class PostsStateError implements PostsState {
  final Object error;

  PostsStateError(this.error);
}

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
