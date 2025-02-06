import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/network/dio_client.dart';
import 'package:plugilo/main/app_flavor.dart';

@singleton
class AuthClient extends DioClient {
  AuthClient(Dio dio) : super(dio, AppConfig.shared.authBaseUrl);
}
