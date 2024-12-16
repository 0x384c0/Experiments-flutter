import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/firebase_auth_screen.dart';
import '../widgets/firebase_chat_screen.dart';

class FirebaseChatRoutesModule extends Module {
  static const path = '/firebase_chat';
  static const chat = '/chat';

  @override
  void routes(r) {
    r.child('/', child: (context) => const FirebaseAuthScreen());
    r.child(chat, child: (context) => FirebaseChatScreen(firebaseUser: r.args.data));
  }
}

class Params {
  static const permalink = 'permalink';
}
