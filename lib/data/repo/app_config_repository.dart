import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/network/api_response.dart';
import 'package:plugilo/core/utils/typedef.dart';
import 'package:plugilo/data/local/app_config_local_data_source.dart';
import 'package:plugilo/data/remote/app_config_remote_data_source.dart';
import 'package:plugilo/domain/app/app_config.dart';

enum ConfigSource {
  local,
  remote,
}

abstract class AppConfigRepository {
  const AppConfigRepository();

  Future<AppConfig?> loadLocalConfig();
  ResultFuture<(AppConfig, ConfigSource)> getFirebaseRemoteConfig();
  Future<void> saveConfig(AppConfig config);

  String? loadTheme();
  Future<bool> saveTheme(String theme);
}

@Injectable(as: AppConfigRepository)
class AppConfigRepositoryImpl implements AppConfigRepository {
  const AppConfigRepositoryImpl(this._localDataSource, this._remoteDataSource);

  final AppConfigLocalDataSource _localDataSource;
  final AppConfigRemoteDataSource _remoteDataSource;

  @override
  Future<AppConfig?> loadLocalConfig() => _localDataSource.loadLocalConfig();

  @override
  Future<void> saveConfig(AppConfig config) => _localDataSource.saveConfig(config);

  @override
  ResultFuture<(AppConfig, ConfigSource)> getFirebaseRemoteConfig() async {
    try {
      final result = await _remoteDataSource.getFirebaseRemoteConfig();
      return Right((result, ConfigSource.remote));
    } on Exception catch (e) {
      final local = await loadLocalConfig();
      if (local != null) {
        return Right((local, ConfigSource.local));
      } else {
        return Left(ApiRespExeption.fromException(e));
      }
    }
  }

  @override
  String? loadTheme() => _localDataSource.loadTheme();

  @override
  Future<bool> saveTheme(String theme) => _localDataSource.saveTheme(theme);
}
