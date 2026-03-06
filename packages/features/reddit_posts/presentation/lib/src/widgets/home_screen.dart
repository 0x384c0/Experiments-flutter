import 'package:auto_route/auto_route.dart';
import 'package:common_presentation/extensions/build_context_theme.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/l10n/app_localizations.g.dart';
import 'package:features_reddit_posts_presentation/src/navigation/router.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view_modifiers/flutter_view_modifiers.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class PostsHomeScreen extends StatelessWidget {
  const PostsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context); // TODO: get from DI
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(title: Text(locale.posts_remote_first), onTap: kIsWeb ? null : () => router.push(PostsRoute())),
        ListTile(
          title: Text(locale.posts_local_first),
          onTap: kIsWeb ? null : () => router.push(LocalFirstPostsRoute()),
        ),
        if (kIsWeb)
          Text(
            'Feature not available due to Reddit CORS policy: strict-origin-when-cross-origin',
            style: context.theme.textTheme.bodySmall?.copyWith(color: context.themeColors.error),
          ).center(),
        const Spacer(),
        ElevatedButton(
          child: Text(locale.posts_clear_sqlite_database),
          onPressed: kIsWeb ? null : () => _clearDb(context),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          child: Text(locale.posts_initialize_sqlite_database),
          onPressed: kIsWeb ? null : () => _initDb(context),
        ),
        const SizedBox(height: 8),
      ],
    ).padding(all: 8);
  }

  _initDb(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    PostsDataSubscription sub = GetIt.instance.get();
    try {
      await sub.initDb();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.posts_sqlite_database_initialized)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(locale.posts_sqlite_database_initialization_error(e))));
      }
    }
  }

  _clearDb(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    PostsDataSubscription sub = GetIt.instance.get();
    try {
      await sub.deleteLocal();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.posts_sqlite_database_cleared)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(locale.posts_sqlite_database_clear_error(e))));
      }
    }
  }
}
