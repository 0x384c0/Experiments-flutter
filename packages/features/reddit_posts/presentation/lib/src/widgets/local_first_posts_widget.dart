import 'package:common_domain/mapper/mapper.dart';
import 'package:common_presentation/widgets/connection_status_view.dart';
import 'package:common_presentation/widgets/scroll_to_end_listener.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';
import 'package:features_reddit_posts_presentation/l10n/app_localizations.g.dart';
import 'package:features_reddit_posts_presentation/src/data/post_state.dart';
import 'package:features_reddit_posts_presentation/src/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_view_modifiers/flutter_view_modifiers.dart';

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

  List<PostItemState> get _listData {
    List<PostItemState> result = [];
    for (var data in _loadedPages.values) {
      result.addAll(_postModelMapper.map(data));
    }
    return result;
  }

  var _isLoading = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.posts_local_first)),
        body: ConnectionStatusView.withChild(
          Stack(
            children: [
              _list(),
              Visibility(
                visible: _listData.isEmpty && _isLoading || _isReSyncing,
                child: _loading(),
              ),
            ],
          ),
          onBackOnline: _onBackOnline,
          onNoConnection: _onNoConnection,
        ),
      );

  Widget _list() => RefreshIndicator(
        onRefresh: _refreshAll,
        child: ScrollToEndListener(
          onScrolledToEnd: _loadNextPage,
          child: (controller) => CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverList.builder(
                  itemCount: _listData.length,
                  itemBuilder: (c, index) => PostTile(
                    _listData[index],
                    () => _onPostTap(_listData[index]),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: _pageLoadingIndicator(_nextPageLoading)),
            ],
          ),
        ),
      );

  Widget _pageLoadingIndicator(bool isLoadingPage) => Visibility(
        visible: isLoadingPage,
        child: const Center(child: CircularProgressIndicator()).padding(all: 8),
      );

  Widget _loading() => Container(
        color: Colors.white.withOpacity(0.5), // Semi-transparent white background
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );

  _onPostTap(PostItemState state) => _navigator.toPostDetails(state);

  Future<void> _refreshAll() async {
    setState(() => _loadedPages.clear());
    await _sub.sync(invalidate: _hasInternetConnection);
  }

  String? get _nextPageKey => _loadedPages.keys.last;

  bool get _nextPageLoading {
    try {
      return _pagesLoadingState.values.contains(true);
    } catch (e) {
      return false;
    }
  }

  final Map<String?, PostsModel> _loadedPages = {};
  final Map<String, bool> _pagesLoadingState = {};

  _loadNextPage() {
    if (_nextPageKey == null) return;
    if (_nextPageLoading) return;
    _listenPageData(_nextPageKey);
  }

  _listenPageData(String? key) {
    if (!_sub.getDataStream(key: key).hasListener) {
      _sub.getDataStream(key: key).stream.listen((data) => setState(() {
            if (data != null) _loadedPages[data.after] = data;
          }));
    }

    if (!_sub.getDataIsLoadingStream(key: key).hasListener) {
      _sub.getDataIsLoadingStream(key: key).stream.listen((isLoading) => setState(() {
            if (key == null) {
              _isLoading = isLoading; // listen first page loading
            } else {
              _pagesLoadingState[key] = isLoading;
            }
          }));
    }
  }

  var _hasInternetConnection = true;

  var _isReSyncing = false;

  _onNoConnection() => _hasInternetConnection = false;

  _onBackOnline() async {
    _hasInternetConnection = true;
    try {
      setState(() => _isReSyncing = true);
      final keys = _loadedPages.keys;
      await _sub.reSync(keys: keys.isNotEmpty ? keys : [null]);
    } catch (e) {
      if (mounted) {
        final manager = ScaffoldMessenger.of(context);
        manager.removeCurrentSnackBar();
        manager.showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      setState(() => _isReSyncing = false);
    }
  }

  @override
  void initState() {
    _listenPageData(null);
    super.initState();
  }

  @override
  void dispose() {
    _sub.disposeStream();
    super.dispose();
  }
}
