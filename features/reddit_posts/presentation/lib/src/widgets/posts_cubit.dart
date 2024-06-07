import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/data/page_state/page_state_cubit.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/post_state.dart';
import '../navigation/navigator.dart';

class PostsCubit extends PageStateCubit<Iterable<PostItemState>> {
  late PostsInteractor interactor = Modular.get();
  late PostsNavigator navigator = Modular.get();
  late Mapper<Iterable<PostModel>, Iterable<PostItemState>> postModelMapper = Modular.get();

  @override
  onRefresh() => interactor.getPosts().then(postModelMapper.map).then(emitData);

  onPostClick(PostItemState state) => navigator.toPostDetails(state);
}
