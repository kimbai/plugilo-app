import 'dart:core';
import 'dart:io';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'package:network_logger/network_logger.dart';
import 'package:plugilo/core/common/event_hub/event_hub.dart';
import 'package:plugilo/core/config/constants.dart';
import 'package:plugilo/core/network/api_meta.dart';
import 'package:plugilo/core/network/api_response.dart';

class DioClient {
  DioClient(this._dio, String baseUrl) {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = Constants.connectionTimeout
      ..options.receiveTimeout = Constants.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(CurlLoggerDioInterceptor())
      ..interceptors.add(DioNetworkLogger());
    // ..interceptors.add(DioInterceptor());
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () => HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
  @factoryMethod
  factory DioClient.from(Dio dio, String baseUrl) => DioClient(dio, baseUrl);

  // dio instance
  final Dio _dio;

  Map<String, String> defaultPayload = {};

  void setAccessToken(String? accessToken) {
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Access-Token'] = accessToken ?? '';
  }

  void removeAccessToken() {
    _dio.options.headers.remove('Access-Token');
  }

  void setHeaderUser(String userId) {
    defaultPayload['UserId'] = userId;
  }

  void removeHeaderUser() {
    defaultPayload.remove('UserId');
  }

  void setDefaultPayload(Map<String, String> payload) {
    defaultPayload = {...defaultPayload, ...payload};
  }

  // Get:-----------------------------------------------------------------------
  Future<Response<dynamic>> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    queryParameters?.removeWhere((key, value) => value == null);
    try {
      final response = await _dio.get<dynamic>(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
        final exeption = ApiRespExeption.fromJson(e.response?.data);
        if (exeption.meta.code == ApiResponseMeta.expiredSession().code || exeption.meta.code == ApiResponseMeta.expiredToken().code) {
          globalEventHub.fire(EventBusType.expiredSession.value);
        }
        throw exeption;
      } else {
        throw ApiRespExeption.fromDioException(e);
      }
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response<dynamic>> post(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    queryParameters?.removeWhere((key, value) => value == null);
    data?.removeWhere((key, value) => value == null);
    final newData = Map<String, dynamic>.from(data ?? {});
    newData.addAll(defaultPayload);
    try {
      final response = await _dio.post<dynamic>(
        uri,
        data: newData,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
        final exeption = ApiRespExeption.fromJson(e.response?.data);
        if (exeption.meta.code == ApiResponseMeta.expiredSession().code || exeption.meta.code == ApiResponseMeta.expiredToken().code) {
          globalEventHub.fire(EventBusType.expiredSession.value);
        }
        throw exeption;
      } else {
        throw ApiRespExeption.fromDioException(e);
      }
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response<dynamic>> put(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    queryParameters?.removeWhere((key, value) => value == null);
    data?.removeWhere((key, value) => value == null);
    final newData = Map<String, dynamic>.from(data ?? {});
    newData.addAll(defaultPayload);
    try {
      final response = await _dio.put<dynamic>(
        uri,
        data: newData,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
        final exeption = ApiRespExeption.fromJson(e.response?.data);
        if (exeption.meta.code == ApiResponseMeta.expiredSession().code || exeption.meta.code == ApiResponseMeta.expiredToken().code) {
          globalEventHub.fire(EventBusType.expiredSession.value);
        }
        throw exeption;
      } else {
        throw ApiRespExeption.fromDioException(e);
      }
    }
  }

  // Patch:-----------------------------------------------------------------------
  Future<Response<dynamic>> patch(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    queryParameters?.removeWhere((key, value) => value == null);
    data?.removeWhere((key, value) => value == null);
    final newData = Map<String, dynamic>.from(data ?? {});
    newData.addAll(defaultPayload);
    try {
      final response = await _dio.patch<dynamic>(
        uri,
        data: newData,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
        final exeption = ApiRespExeption.fromJson(e.response?.data);
        if (exeption.meta.code == ApiResponseMeta.expiredSession().code || exeption.meta.code == ApiResponseMeta.expiredToken().code) {
          globalEventHub.fire(EventBusType.expiredSession.value);
        }
        throw exeption;
      } else {
        throw ApiRespExeption.fromDioException(e);
      }
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<Response<dynamic>> delete(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    queryParameters?.removeWhere((key, value) => value == null);
    data?.removeWhere((key, value) => value == null);
    final newData = Map<String, dynamic>.from(data ?? {});
    newData.addAll(defaultPayload);
    try {
      final response = await _dio.delete<dynamic>(
        uri,
        data: newData,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
        final exeption = ApiRespExeption.fromJson(e.response?.data);
        if (exeption.meta.code == ApiResponseMeta.expiredSession().code || exeption.meta.code == ApiResponseMeta.expiredToken().code) {
          globalEventHub.fire(EventBusType.expiredSession.value);
        }
        throw exeption;
      } else {
        throw ApiRespExeption.fromDioException(e);
      }
    }
  }

  // Download:--------------------------------------------------------------------
  Future<Response<dynamic>> download(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    queryParameters?.removeWhere((key, value) => value == null);
    try {
      final response = await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        lengthHeader: lengthHeader,
        deleteOnError: deleteOnError,
        cancelToken: cancelToken,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
        final exeption = ApiRespExeption.fromJson(e.response?.data);
        if (exeption.meta.code == ApiResponseMeta.expiredSession().code || exeption.meta.code == ApiResponseMeta.expiredToken().code) {
          globalEventHub.fire(EventBusType.expiredSession.value);
        }
        throw exeption;
      } else {
        throw ApiRespExeption.fromDioException(e);
      }
    }
  }

  Future<Response<dynamic>> downloadUri(
    Uri uri,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    try {
      final response = await _dio.download(
        uri.toString(),
        savePath,
        onReceiveProgress: onReceiveProgress,
        lengthHeader: lengthHeader,
        deleteOnError: deleteOnError,
        cancelToken: cancelToken,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
        final exeption = ApiRespExeption.fromJson(e.response?.data);
        if (exeption.meta.code == ApiResponseMeta.expiredSession().code || exeption.meta.code == ApiResponseMeta.expiredToken().code) {
          globalEventHub.fire(EventBusType.expiredSession.value);
        }
        throw exeption;
      } else {
        throw ApiRespExeption.fromDioException(e);
      }
    }
  }
}
