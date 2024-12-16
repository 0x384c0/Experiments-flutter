import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'module.dart';

/// Navigation for weather feature
abstract class FirebaseChatNavigator {
  toFirebaseChat(User user);

  toFirebaseChatAuthorization();
}

/// Private implementation if weather navigation
class NavigatorImpl implements FirebaseChatNavigator {
  @override
  toFirebaseChat(User user) => Modular.to.pushNamed(
        '${FirebaseChatRoutesModule.path}${FirebaseChatRoutesModule.chat}',
        arguments: user,
      );

  @override
  toFirebaseChatAuthorization() => Modular.to.pushNamed(FirebaseChatRoutesModule.path);
}
