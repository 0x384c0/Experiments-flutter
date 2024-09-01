import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
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
        const Spacer(),
        ElevatedButton(
          onPressed: () => _clearDb(context),
          child: Text(locale.posts_clear_sqlite_database),
        ),
        ElevatedButton(
          onPressed: () => _initDb(context),
          child: Text(locale.posts_initialize_sqlite_database),
        ),
        const SizedBox(height: 8),
      ],
    ).padding(all: 8);
  }

  _initDb(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    PostsDataSubscription sub = Modular.get();
    try {
      await sub.initDb();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.posts_sqlite_database_initialized)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(locale.posts_sqlite_database_initialization_error(e))));
      }
    }
  }

  _clearDb(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    PostsDataSubscription sub = Modular.get();
    try {
      await sub.deleteLocal();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.posts_sqlite_database_cleared)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(locale.posts_sqlite_database_clear_error(e))));
      }
    }
  }
}
