import 'package:features_firebase_chat_presentation/features_firebase_chat_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:widgets_modifiers/style/styling_widgets_modifiers.dart';

class OthersScreen extends StatelessWidget {
  const OthersScreen({super.key});


  FirebaseChatNavigator get _navigator => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: const Text('Firebase chat'),
          onTap: _navigator.toFirebaseChatAuthorization,
        ),
      ],
    ).padding(all: 8);
  }
}
