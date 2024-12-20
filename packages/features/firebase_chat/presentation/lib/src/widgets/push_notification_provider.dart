import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class PushNotificationProvider {
  Future start();

  Future stop();
}

abstract interface class FirebaseTokenRepository {
  Future setFcmToken(String token);

  Future clean();
}

class PushNotificationModel {
  PushNotificationModel(
    this.data,
  );

  final Map<String, dynamic>? data;
}

abstract interface class PushNotificationNavigator {
  void onPushNotificationTap(PushNotificationModel model);
}

class PushNotificationProviderImpl implements PushNotificationProvider {
  static const _defaultTitle = 'Notification';
  static const _notificationChannel = 'app_notifications';

  // Generate icons with https://romannurik.github.io/AndroidAssetStudio/icons-notification.html
  static const _androidIcon = '@drawable/launch_background';
  static const _notificationIcon = '@drawable/ic_notification';

  PushNotificationProviderImpl(
    this._firebaseTokenRepository,
    this._pushNotificationNavigator,
  );

  final FirebaseTokenRepository _firebaseTokenRepository;
  final PushNotificationNavigator _pushNotificationNavigator;

  @override
  Future start() async {
    if (_subscriptions.isNotEmpty) return;
    try {
      await _listenToNotifications();
    } catch (_) {}
  }

  @override
  Future stop() async {
    if (_subscriptions.isEmpty) return;
    for (final element in _subscriptions) {
      await element.cancel();
    }
    _subscriptions.clear();
  }

  _onNotificationSelect(RemoteMessage? message) =>
      _pushNotificationNavigator.onPushNotificationTap(PushNotificationModel(message?.data));

  Future<AuthorizationStatus> _listenToNotifications() async {
    final status = await _handlePermissions();
    if (status == AuthorizationStatus.denied || status == AuthorizationStatus.notDetermined) return status;
    if (_subscriptions.isEmpty) {
      _subscriptions.add(await _handleFcmToken());
      _subscriptions.add(await _handleBackgroundMessages());
      if (_handleForegroundAndroidMessages() case final subscription?) {
        _subscriptions.add(subscription);
      }
    }
    return status;
  }

  final _subscriptions = <StreamSubscription<dynamic>>[];

  Future<AuthorizationStatus> _handlePermissions() async {
    final status = (await FirebaseMessaging.instance.requestPermission()).authorizationStatus;
    if (status != AuthorizationStatus.denied && status != AuthorizationStatus.notDetermined) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    }
    return status;
  }

  Future<StreamSubscription<dynamic>> _handleFcmToken() async {
    await _sendToken(await FirebaseMessaging.instance.getToken());
    return FirebaseMessaging.instance.onTokenRefresh.listen(_sendToken);
  }

  Future _sendToken(String? fcmToken) async {
    try {
      if (fcmToken != null) await _firebaseTokenRepository.setFcmToken(fcmToken);
    } catch (_) {}
  }

  Future<StreamSubscription<dynamic>> _handleBackgroundMessages() async {
    final result = FirebaseMessaging.onMessageOpenedApp.listen(_onNotificationSelect);
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) _onNotificationSelect(initialMessage);
    return result;
  }

  StreamSubscription<dynamic>? _handleForegroundAndroidMessages() {
    if (!Platform.isAndroid) return null;
    _initializeLocalNotifications();
    return FirebaseMessaging.onMessage.listen((message) => _displayCustomNotification(message));
  }

  late final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isLocalNotificationsInitialized = false;

  Future _initializeLocalNotifications() async {
    if (_isLocalNotificationsInitialized) return;
    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: AndroidInitializationSettings(_androidIcon)),
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
    _isLocalNotificationsInitialized = true;
  }

  _onDidReceiveNotificationResponse(NotificationResponse response) {
    var message = _pendingLocalMessages[response.payload];
    if (message == null) {
      try {
        message = RemoteMessage(data: json.decode(response.payload ?? '{}'));
      } catch (_) {}
    }
    return _onNotificationSelect(message);
  }

  final _pendingLocalMessages = <String, RemoteMessage>{};

  Future<void> _displayCustomNotification(RemoteMessage message) async {
    final androidDetails = AndroidNotificationDetails(
      _notificationChannel,
      message.notification?.title ?? _defaultTitle,
      importance: Importance.max,
      priority: Priority.high,
      icon: _notificationIcon,
    );

    final details = NotificationDetails(android: androidDetails);
    try {
      final payload = _getJsonPayload(message);
      await _flutterLocalNotificationsPlugin.show(
        message.messageId?.hashCode ?? message.hashCode,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        details,
        payload: payload,
      );
      _pendingLocalMessages[payload] = message;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String _getJsonPayload(RemoteMessage message) {
    final hashCode = message.messageId ?? message.hashCode.toString();
    try {
      message.data['id'] = hashCode;
      return json.encode(message.data);
    } catch (e) {
      final map = {'id': hashCode};
      return json.encode(map);
    }
  }
}
