import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  final FlutterLocalNotificationsPlugin _notiPlugin = FlutterLocalNotificationsPlugin();

  static final LocalNotification _instance = LocalNotification._internal();

  factory LocalNotification() {
    return _instance;
  }

  LocalNotification._internal();

  void initialize(Function(NotificationResponse details)? onDidReceiveNotificationResponse) {
    const InitializationSettings initialSettings = InitializationSettings(
      android: AndroidInitializationSettings(
        "app_icon",
      ),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    _notiPlugin.initialize(initialSettings, onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void showNotification(RemoteMessage message) {
    const NotificationDetails notiDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'oeg.push_notification',
        'push_notification',
        importance: Importance.max,
        priority: Priority.high,
        icon: 'app_icon',
      ),
    );
    _notiPlugin.show(
      DateTime.now().microsecond,
      message.notification?.title ?? 'Opay',
      message.notification?.body ?? '',
      notiDetails,
      payload: jsonEncode(message.data),
    );
  }
}
