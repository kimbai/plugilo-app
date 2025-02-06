// coverage:ignore-file
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/network/api_response.dart';
import 'package:plugilo/core/network/auth_client.dart';
import 'package:plugilo/domain/response/login_response.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  void updateAccessToken(String? accessToken);

  Future<LoginResponse> signIn({
    required String userName,
    required String password,
  });

  Future<ApiResponse> logout();
}

sealed class Endpoint {
  const Endpoint._();

  static const signIn = 'api/v2/login';
  static const logout = 'ite-ew-mobile-service/auth/logout';
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);

  final AuthClient _client;

  @override
  void updateAccessToken(String? accessToken) {
    if (accessToken == null) {
      _client.removeAccessToken();
    } else {
      _client.setAccessToken(accessToken);
    }
  }

  @override
  Future<LoginResponse> signIn({
    required String userName,
    required String password,
  }) async {
    try {
      final response = await _client.post("${Endpoint.signIn}?redirect_uri=plugilo.mobile://welcome", data: {
        'username': userName,
        'password': password,
      });
      return LoginResponse.fromJson(response.data);
    } on ApiRespExeption {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> logout() async {
    try {
      final response = await _client.post(Endpoint.logout);
      return ApiResponse.fromJson(response.data, (json) => json);
    } on ApiRespExeption {
      rethrow;
    }
  }
}
