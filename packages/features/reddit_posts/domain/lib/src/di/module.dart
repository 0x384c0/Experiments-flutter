import 'package:features_reddit_posts_domain/src/use_cases/posts_data_subscription.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../features_reddit_posts_domain.dart';
import '../use_cases/interactor_impl.dart';

class PostsDomainModule extends Module {
  PostsDomainModule(this.imports);

  @override
  final List<Module> imports;

  @override
  exportedBinds(Injector i) {
    i.add<PostsInteractor>(PostsInteractorImpl.new);
    i.add<PostsDataSubscription>(PostsDataSubscription.new);
  }
}
