import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/connection_status_view.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/l10n/app_localizations.g.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:features_reddit_posts_presentation/src/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'post_tile.dart';

class LocalFirstPostsWidget extends StatefulWidget {
  const LocalFirstPostsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LocalFirstPostsWidgetState();
}

class _LocalFirstPostsWidgetState extends State<LocalFirstPostsWidget> {
  late final Mapper<PostsModel, Iterable<PostItemState>> _postModelMapper = Modular.get();
  late final PostsNavigator _navigator = Modular.get();
  final PostsDataSubscription _sub = Modular.get();
  List<PostItemState> _listData = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.posts_local_first)),
        body: ConnectionStatusView.withChild(
          ListView.builder(
            itemCount: _listData.length,
            itemBuilder: (c, index) => PostTile(
              _listData[index],
              () => _onPostTap(_listData[index]),
            ),
          ),
        ),
      );

  _onPostTap(PostItemState state) => _navigator.toPostDetails(state);

  @override
  void initState() {
    _sub.getDataStream().listen(
          (data) => setState(() {
            _listData = data != null ? _postModelMapper.map(data).toList() : [];
          }),
        );
    super.initState();
  }
}
