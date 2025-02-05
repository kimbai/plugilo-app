import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:plugilo/domain/app/app_config.dart';

abstract class AppConfigRemoteDataSource {
  const AppConfigRemoteDataSource();

  Future<AppConfig> getFirebaseRemoteConfig();
}

@Injectable(as: AppConfigRemoteDataSource)
class AppConfigRemoteDataSourceImpl implements AppConfigRemoteDataSource {
  const AppConfigRemoteDataSourceImpl();

  @override
  Future<AppConfig> getFirebaseRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    final packageInfo = await PackageInfo.fromPlatform();
    await remoteConfig.setDefaults({
      'android_version': packageInfo.version,
      'android_show_update': false,
      'android_force_update': false,
      'ios_version': packageInfo.version,
      'ios_show_update': false,
      'ios_force_update': false,
    });

    await FirebaseRemoteConfig.instance.fetchAndActivate();
    return AppConfig.from(remoteConfig);
  }
}
