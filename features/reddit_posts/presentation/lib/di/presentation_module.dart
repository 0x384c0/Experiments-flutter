import 'package:common_domain/mapper/mapper.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_presentation/data/post_details_state.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:features_reddit_posts_presentation/mapper/post_model_mapper.dart';
import 'package:features_reddit_posts_presentation/mapper/post_models_mapper.dart';
import 'package:features_reddit_posts_presentation/navigation/navigator.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostsPresentationModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.addSingleton<Mapper<Iterable<PostModel>, PostsState>>(PostModelsMapper.new);
    i.addSingleton<Mapper<PostModel, PostDetailsState>>(PostModelMapper.new);
    i.addSingleton<PostsNavigator>(NavigatorImpl.new);
  }
}
