import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/config/constants.dart';
import 'package:plugilo/domain/auth/access_token.dart';
import 'package:plugilo/domain/auth/user.dart';

abstract class AuthLocalDataSource {
  const AuthLocalDataSource();

  Future<AccessToken?> getAccessToken();
  Future<void> saveAccessToken(AccessToken token);
  Future<void> clearAccessToken();

  Future<User?> getLoggedUserInfo();
  Future<void> saveLoggedUserInfo(User user);
  Future<void> clearLoggedUserInfo();
}

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<AccessToken?> getAccessToken() async {
    AccessToken? accessToken;
    final tokenJsonStr = await _storage.read(key: Constants.lsKeyAccessToken);
    if (tokenJsonStr != null) {
      try {
        final tokenJson = jsonDecode(tokenJsonStr) as Map<String, dynamic>;
        accessToken = AccessToken.fromJson(tokenJson);
      } catch (e) {
        // debugPrint(e.toString());
      }
    }
    return accessToken;
  }

  @override
  Future<void> saveAccessToken(AccessToken token) async {
    final tokenJsonStr = jsonEncode(token.toJson());
    await _storage.write(key: Constants.lsKeyAccessToken, value: tokenJsonStr);
  }

  @override
  Future<void> clearAccessToken() async {
    await _storage.delete(key: Constants.lsKeyAccessToken);
  }

  @override
  Future<User?> getLoggedUserInfo() async {
    final userStr = await _storage.read(key: Constants.lsKeyLoggedUserInfo);
    if (userStr != null) {
      try {
        final userJson = jsonDecode(userStr) as Map<String, dynamic>;
        return User.fromJson(userJson);
      } catch (e) {
        // debugPrint(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<void> saveLoggedUserInfo(User user) async {
    final userStr = jsonEncode(user.toJson());
    await _storage.write(key: Constants.lsKeyLoggedUserInfo, value: userStr);
  }

  @override
  Future<void> clearLoggedUserInfo() async {
    await _storage.delete(key: Constants.lsKeyLoggedUserInfo);
  }
}
