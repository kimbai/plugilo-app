// coverage:ignore-file
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/network/api_response.dart';
import 'package:plugilo/core/network/dio_client.dart';
import 'package:plugilo/domain/auth/access_token.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  void updateAccessToken(String? accessToken);

  Future<ApiResponse<AccessToken>> signIn({
    required String phoneNo,
    required String password,
  });

  Future<ApiResponse> logout();
}

sealed class Endpoint {
  const Endpoint._();

  static const signIn = 'ite-ew-mobile-service/auth/login';
  static const logout = 'ite-ew-mobile-service/auth/logout';
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  void updateAccessToken(String? accessToken) {
    if (accessToken == null) {
      _client.removeAccessToken();
    } else {
      _client.setAccessToken(accessToken);
    }
  }

  @override
  Future<ApiResponse<AccessToken>> signIn({
    required String phoneNo,
    required String password,
  }) async {
    try {
      final response = await _client.post(Endpoint.signIn, data: {
        'PhoneNo': phoneNo,
        'Password': password,
      });
      return ApiResponse.fromJson(response.data, AccessToken.fromJson);
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
