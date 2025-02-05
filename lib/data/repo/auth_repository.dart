import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/network/api_response.dart';
import 'package:plugilo/core/utils/typedef.dart';
import 'package:plugilo/data/local/auth_local_data_source.dart';
import 'package:plugilo/data/remote/auth_remote_data_source.dart';
import 'package:plugilo/domain/auth/access_token.dart';
import 'package:plugilo/domain/auth/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  void dioUpdateAccessToken(String? accessToken);

  // local data source
  Future<AccessToken?> getAccessToken();
  Future<void> saveAccessToken(AccessToken token);
  Future<void> clearAccessToken();

  Future<User?> getLoggedUserInfo();
  Future<void> saveLoggedUserInfo(User user);
  Future<void> clearLoggedUserInfo();

  // remote data source
  ResultFuture<ApiResponse<AccessToken>> signIn({
    required String phoneNo,
    required String password,
  });

  ResultFuture<ApiResponse> logout();
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._localDataSource, this._remoteDataSource);

  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  @override
  void dioUpdateAccessToken(String? accessToken) => _remoteDataSource.updateAccessToken(accessToken);

  // local data source
  @override
  Future<AccessToken?> getAccessToken() => _localDataSource.getAccessToken();

  @override
  Future<void> saveAccessToken(AccessToken token) => _localDataSource.saveAccessToken(token);

  @override
  Future<void> clearAccessToken() => _localDataSource.clearAccessToken();

  @override
  Future<User?> getLoggedUserInfo() => _localDataSource.getLoggedUserInfo();

  @override
  Future<void> saveLoggedUserInfo(User user) => _localDataSource.saveLoggedUserInfo(user);

  @override
  Future<void> clearLoggedUserInfo() => _localDataSource.clearLoggedUserInfo();

  // remote data source
  @override
  ResultFuture<ApiResponse<AccessToken>> signIn({
    required String phoneNo,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        phoneNo: phoneNo,
        password: password,
      );
      return Right(result);
    } on ApiRespExeption catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<ApiResponse> logout() async {
    try {
      final result = await _remoteDataSource.logout();
      return Right(result);
    } on ApiRespExeption catch (e) {
      return Left(e);
    }
  }
}
