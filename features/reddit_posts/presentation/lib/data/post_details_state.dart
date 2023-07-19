import 'post_state.dart';

abstract class PostDetailsState {}

class PostDetailsStateEmpty implements PostDetailsState {}

class PostDetailsStatePopulated implements PostDetailsState {
  final Map<String?, PostItemState?> postsDetails;

  PostDetailsStatePopulated(this.postsDetails);
}

class PostDetailsStateError implements PostDetailsState {
  final Object error;

  PostDetailsStateError(this.error);
}