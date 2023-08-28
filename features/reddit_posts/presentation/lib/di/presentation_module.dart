import 'package:common_presentation/data/mapper.dart';
import 'package:features_reddit_posts_domain/data/post_model.dart';
import 'package:features_reddit_posts_presentation/data/post_details_state.dart';
import 'package:features_reddit_posts_presentation/data/post_state.dart';
import 'package:features_reddit_posts_presentation/mapper/post_model_mapper.dart';
import 'package:features_reddit_posts_presentation/mapper/post_models_mapper.dart';
import 'package:features_reddit_posts_presentation/navigation/navigator.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PresentationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Navigator>(
          (i) => NavigatorImpl(),
          export: true,
        ),
        Bind<Mapper<Iterable<PostModel>, PostsState>>(
          (i) => PostModelsMapper(),
          export: true,
        ),
        Bind<Mapper<PostModel, PostDetailsState>>(
          (i) => PostModelMapper(),
          export: true,
        ),
      ];
}
