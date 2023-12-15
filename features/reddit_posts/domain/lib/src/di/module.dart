import 'package:flutter_modular/flutter_modular.dart';

import '../../features_reddit_posts_domain.dart';
import '../use_cases/interactor_impl.dart';

class PostsDomainModule extends Module {
  PostsDomainModule(this.imports);

  @override
  final List<Module> imports;

  @override
  exportedBinds(Injector i) {
    i.addSingleton<PostsInteractor>(PostsInteractorImpl.new);
  }
}
