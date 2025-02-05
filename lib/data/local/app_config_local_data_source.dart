import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/config/constants.dart';
import 'package:plugilo/domain/app/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppConfigLocalDataSource {
  const AppConfigLocalDataSource();

  Future<AppConfig?> loadLocalConfig();
  Future<void> saveConfig(AppConfig config);

  String? loadTheme();
  Future<bool> saveTheme(String theme);
}

@Injectable(as: AppConfigLocalDataSource)
class AppConfigLocalDataSourceImpl implements AppConfigLocalDataSource {
  const AppConfigLocalDataSourceImpl(this._storage, this._sharedPreferences);

  final FlutterSecureStorage _storage;
  final SharedPreferences _sharedPreferences;

  @override
  Future<AppConfig?> loadLocalConfig() async {
    final value = await _storage.read(key: Constants.lsKeyAppConfig);
    if (value == null) {
      return null;
    }
    return AppConfig.fromJson(jsonDecode(value));
  }

  @override
  Future<void> saveConfig(AppConfig config) {
    return _storage.write(key: Constants.lsKeyAppConfig, value: jsonEncode(config.toJson()));
  }

  @override
  String? loadTheme() {
    return _sharedPreferences.getString(Constants.lsKeyConfigTheme);
  }

  @override
  Future<bool> saveTheme(String theme) async {
    return _sharedPreferences.setString(Constants.lsKeyConfigTheme, theme);
  }
}
