import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/src/mapper/post_model_to_post_item_state_mapper.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../features_reddit_posts_presentation.dart';
import '../data/post_details_state.dart';
import '../data/post_state.dart';
import '../mapper/post_model_to_post_details_mapper.dart';
import '../mapper/post_models_mapper.dart';

class PostsPresentationModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.add<Mapper<PostsModel, Iterable<PostItemState>>>(PostModelsMapper.new);
    i.add<Mapper<PostModel, PostDetailsState>>(PostModelToPostDetailsStateMapper.new);
    i.add<Mapper<PostModel, PostItemState>>(PostModelToPostItemStateMapper.new);
    i.add<PostsNavigator>(NavigatorImpl.new);
  }
}
