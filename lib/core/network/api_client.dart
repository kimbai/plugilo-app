import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:plugilo/core/network/dio_client.dart';
import 'package:plugilo/main/app_flavor.dart';

@singleton
class ApiClient extends DioClient {
  ApiClient(Dio dio) : super(dio, AppConfig.shared.baseUrl);
}
