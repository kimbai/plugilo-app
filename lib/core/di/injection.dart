import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/di/injection.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

@InjectableInit()
void configureDependencies() => serviceLocator.init();

@module
abstract class InjectionModule {
  // storage
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  Dio get dio => Dio();

  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
}
