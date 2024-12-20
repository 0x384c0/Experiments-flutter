import 'package:features_firebase_chat_presentation/features_firebase_chat_presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FirebaseChatPresentationModule extends Module {
  @override
  exportedBinds(Injector i) {
    i.add<FirebaseChatNavigator>(NavigatorImpl.new);
  }
}
