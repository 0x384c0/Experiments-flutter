import 'package:auto_route/auto_route.dart';
import 'package:features_firebase_chat_presentation/src/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view_modifiers/flutter_view_modifiers.dart';

@RoutePage()
class OthersScreen extends StatelessWidget {
  const OthersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: const Text('Firebase chat'),
          onTap: () => AutoRouter.of(context).push(FirebaseAuthRoute()),
        ),
      ],
    ).padding(all: 8);
  }
}
