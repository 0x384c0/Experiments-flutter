import 'package:features_reddit_posts_domain/usecases/interactor.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostsDomainModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.addSingleton<PostsInteractor>(() => PostsInteractorImpl(Modular.get()));
  }
}
