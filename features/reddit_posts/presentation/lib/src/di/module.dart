import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../features_reddit_posts_presentation.dart';
import '../data/post_details_state.dart';
import '../data/post_state.dart';
import '../mapper/post_model_mapper.dart';
import '../mapper/post_models_mapper.dart';

class PostsPresentationModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.addSingleton<Mapper<Iterable<PostModel>, PostsState>>(PostModelsMapper.new);
    i.addSingleton<Mapper<PostModel, PostDetailsState>>(PostModelMapper.new);
    i.addSingleton<PostsNavigator>(NavigatorImpl.new);
  }
}
