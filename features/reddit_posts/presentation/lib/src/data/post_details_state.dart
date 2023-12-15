import 'post_state.dart';

abstract class PostDetailsState {
  final String? permalink;

  PostDetailsState(this.permalink);
}

class PostDetailsStateEmpty implements PostDetailsState {
  @override
  final String? permalink;

  PostDetailsStateEmpty(this.permalink);
}

class PostDetailsStateEmptyComments implements PostDetailsState {
  @override
  final String? permalink;
  final PostItemState postItemState;

  PostDetailsStateEmptyComments(this.permalink, this.postItemState);
}

class PostDetailsStatePopulated implements PostDetailsState {
  @override
  final String? permalink;
  final PostItemState postItemState;

  PostDetailsStatePopulated(this.permalink, this.postItemState);
}

class PostDetailsStateError implements PostDetailsState {
  @override
  final String? permalink;
  final Object error;

  PostDetailsStateError(this.permalink, this.error);
}