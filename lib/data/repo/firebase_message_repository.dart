import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseMessageRepository {
  const FirebaseMessageRepository();

  Future<String?> register();
  Future<String?> getToken();
  void onRefreshToken(void Function(String token) onRefreshToken);

  void onMessage(void Function(RemoteMessage? message) onMessage);

  void onMessageOpenedApp(void Function(RemoteMessage message) onMessageOpenedApp);

  Future<RemoteMessage?> getInitialMessage(void Function(RemoteMessage message) onMessage);
}

@Injectable(as: FirebaseMessageRepository)
class FirebaseMessageRepositoryImpl extends FirebaseMessageRepository {
  final FirebaseMessaging _firebaseMessaging;

  FirebaseMessageRepositoryImpl(this._firebaseMessaging);

  @override
  Future<String?> register() async {
    final result = await _firebaseMessaging.requestPermission();
    if (result.authorizationStatus == AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      try {
        final token = await _firebaseMessaging.getToken();
        return token;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  @override
  void onRefreshToken(void Function(String token) onRefreshToken) {
    _firebaseMessaging.onTokenRefresh.listen(onRefreshToken);
  }

  @override
  void onMessage(void Function(RemoteMessage message) onMessage) {
    FirebaseMessaging.onMessage.listen(onMessage);
  }

  @override
  void onMessageOpenedApp(void Function(RemoteMessage message) onMessageOpenedApp) {
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
  }

  @override
  Future<RemoteMessage?> getInitialMessage(void Function(RemoteMessage message) onMessage) async {
    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      onMessage(message);
    }
    return message;
  }
}
