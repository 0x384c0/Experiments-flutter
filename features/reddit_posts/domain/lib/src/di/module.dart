import 'package:flutter_modular/flutter_modular.dart';

import '../../features_reddit_posts_domain.dart';
import '../use_cases/interactor_impl.dart';

class PostsDomainModule extends Module {
  @override
  exportedBinds(Injector i) {
    // After flutter_modular:6.0.0 we cannot use PostsInteractorImpl.new, because Injector here does not contain binds from other modules
    // Ways to get binds from other modules
    // 1. Bypass Injector and get it from Modular.get()
    // 2. Pass other modules in this module and put the in to List<Module> imports
    i.addSingleton<PostsInteractor>(() => PostsInteractorImpl(Modular.get()));
  }
}
