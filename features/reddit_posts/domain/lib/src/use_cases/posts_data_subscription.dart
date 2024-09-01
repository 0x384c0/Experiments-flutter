import 'dart:async';

import 'package:features_reddit_posts_domain/src/data/post_model.dart';
import 'package:features_reddit_posts_domain/src/repository/local_repository.dart';
import 'package:features_reddit_posts_domain/src/repository/remote_repository.dart';
import 'package:flutter/foundation.dart';

abstract class DataSubscription<T, K> {
  final _dataStreamControllerMap = <K?, StreamController<T?>>{};
  final _dataIsLoadingControllerMap = <K?, StreamController<bool>>{};

  StreamController<T?> getDataStream({K? key}) => _getStream(key, _dataStreamControllerMap, true);

  StreamController<bool> getDataIsLoadingStream({K? key}) => _getStream(key, _dataIsLoadingControllerMap, false);

  disposeStream({K? key}) {
    _dataStreamControllerMap[key]?.close();
    _dataStreamControllerMap.remove(key);
    _dataIsLoadingControllerMap[key]?.close();
    _dataIsLoadingControllerMap.remove(key);
  }

  sync({
    K? key,
    bool invalidate = false,
  }) async {
    if (await isOnline && invalidate) await deleteLocal();
    await _sendLocalToStream(key);
    await _syncLocalWithRemote(key);
    await _sendLocalToStream(key);
  }

  //TODO: move to separate class, try make it faster
  Future initDb() async => await getLocal(null);

  StreamController<_T> _getStream<_T>(K? key, Map<K?, StreamController<_T>> map, bool syncOnListen) {
    final StreamController<_T> dataStreamController;
    if (map.containsKey(key)) {
      dataStreamController = map[key]!;
    } else {
      dataStreamController = StreamController<_T>();
      map[key] = dataStreamController;
      if (syncOnListen) dataStreamController.onListen = () => sync(key: key);
    }
    return dataStreamController;
  }

  _sendLocalToStream(K? key) async {
    final data = await getLocal(key);
    if (data != null) {
      _dataStreamControllerMap[key]?.sink.add(data);
    } else {
      _dataStreamControllerMap[key]?.sink.add(null);
    }
  }

  _syncLocalWithRemote(K? key) async {
    try {
      _dataIsLoadingControllerMap[key]?.add(true);
      if (await isOnline) {
        final local = await getRemote(key);
        if (local != null) {
          await insertLocal(local, key);
        }
      }
    } finally {
      _dataIsLoadingControllerMap[key]?.add(false);
    }
  }

  @visibleForOverriding
  Future<bool> get isOnline;

  @visibleForOverriding
  Future<T> getRemote(K? key);

  @visibleForOverriding
  Future<T?> getLocal(K? key);

  @visibleForOverriding
  Future insertLocal(T data, K? key);

  @visibleForOverriding
  Future deleteLocal();
}

class PostsDataSubscription extends DataSubscription<PostsModel, String> {
  PostsDataSubscription(
    this._remoteRepository,
    this._localRepository,
  );

  final PostsRemoteRepository _remoteRepository;
  final PostsLocalRepository _localRepository;

  @override
  Future deleteLocal() => _localRepository.deletePosts();

  @override
  Future<PostsModel?> getLocal(String? key) => _localRepository.getPosts(after: key);

  @override
  Future<PostsModel> getRemote(String? key) => _remoteRepository.getPosts(after: key);

  @override
  Future insertLocal(PostsModel data, String? key) => _localRepository.insertPosts(data, after: key);

  @override
  Future<bool> get isOnline async => true;
}
