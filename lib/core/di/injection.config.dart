// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:plugilo/core/common/cubit/auth_cubit.dart' as _i257;
import 'package:plugilo/core/common/cubit/theme_cubit.dart' as _i824;
import 'package:plugilo/core/di/injection.dart' as _i1034;
import 'package:plugilo/core/network/api_client.dart' as _i51;
import 'package:plugilo/core/network/auth_client.dart' as _i440;
import 'package:plugilo/data/local/app_config_local_data_source.dart' as _i565;
import 'package:plugilo/data/local/auth_local_data_source.dart' as _i146;
import 'package:plugilo/data/remote/app_config_remote_data_source.dart'
    as _i499;
import 'package:plugilo/data/remote/auth_remote_data_source.dart' as _i533;
import 'package:plugilo/data/repo/app_config_repository.dart' as _i538;
import 'package:plugilo/data/repo/auth_repository.dart' as _i424;
import 'package:plugilo/data/repo/firebase_message_repository.dart' as _i735;
import 'package:plugilo/presentation/sign_in/cubit/sign_in_cubit.dart' as _i739;
import 'package:plugilo/presentation/splash/cubit/splash_cubit.dart' as _i835;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.factory<_i558.FlutterSecureStorage>(() => injectionModule.secureStorage);
    gh.factory<_i361.Dio>(() => injectionModule.dio);
    gh.factory<_i892.FirebaseMessaging>(
        () => injectionModule.firebaseMessaging);
    gh.factory<_i835.SplashCubit>(() => _i835.SplashCubit());
    gh.factory<_i735.FirebaseMessageRepository>(() =>
        _i735.FirebaseMessageRepositoryImpl(gh<_i892.FirebaseMessaging>()));
    gh.factory<_i499.AppConfigRemoteDataSource>(
        () => const _i499.AppConfigRemoteDataSourceImpl());
    gh.singleton<_i440.AuthClient>(() => _i440.AuthClient(gh<_i361.Dio>()));
    gh.singleton<_i51.ApiClient>(() => _i51.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i565.AppConfigLocalDataSource>(
        () => _i565.AppConfigLocalDataSourceImpl(
              gh<_i558.FlutterSecureStorage>(),
              gh<_i460.SharedPreferences>(),
            ));
    gh.factory<_i538.AppConfigRepository>(() => _i538.AppConfigRepositoryImpl(
          gh<_i565.AppConfigLocalDataSource>(),
          gh<_i499.AppConfigRemoteDataSource>(),
        ));
    gh.factory<_i146.AuthLocalDataSource>(
        () => _i146.AuthLocalDataSourceImpl(gh<_i558.FlutterSecureStorage>()));
    gh.factory<_i533.AuthRemoteDataSource>(
        () => _i533.AuthRemoteDataSourceImpl(gh<_i440.AuthClient>()));
    gh.singleton<_i824.ThemeCubit>(() =>
        _i824.ThemeCubit(appConfigRepository: gh<_i538.AppConfigRepository>()));
    gh.factory<_i424.AuthRepository>(() => _i424.AuthRepositoryImpl(
          gh<_i146.AuthLocalDataSource>(),
          gh<_i533.AuthRemoteDataSource>(),
        ));
    gh.singleton<_i257.AuthCubit>(
        () => _i257.AuthCubit(authRepository: gh<_i424.AuthRepository>()));
    gh.factory<_i739.SignInCubit>(
        () => _i739.SignInCubit(gh<_i424.AuthRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i1034.InjectionModule {}
