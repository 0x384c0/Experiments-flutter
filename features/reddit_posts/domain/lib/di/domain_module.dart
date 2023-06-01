import 'package:features_reddit_posts_domain/usecases/interactor.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DomainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<PostsInteractor>(
          (i) => PostsInteractorImpl(),
          export: true,
        ),
      ];
}
