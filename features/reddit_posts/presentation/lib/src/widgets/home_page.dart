import 'package:features_reddit_posts_presentation/l10n/app_localizations.g.dart';
import 'package:features_reddit_posts_presentation/src/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:widgets_modifiers/style/styling_widgets_modifiers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  PostsNavigator get _navigator => Modular.get();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(locale.posts_remote_first),
          onTap: _navigator.toPostsRemoteFirst,
        ),
        ListTile(
          title: Text(locale.posts_local_first),
          onTap: _navigator.toPostsLocalFirst,
        ),
      ],
    ).padding(all: 8);
  }
}
