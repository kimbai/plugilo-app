import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:plugilo/core/network/api_meta.dart';
import 'package:plugilo/core/utils/cast.dart';
import 'package:plugilo/generated/locale_keys.g.dart';

class ApiResponse<T> extends Equatable {
  const ApiResponse({
    this.data,
    this.meta,
  });
  final T? data;
  final ApiResponseMeta? meta;

  factory ApiResponse.fromJson(Map<String, dynamic>? map, T Function(Map<String, dynamic>? json)? fromJson) {
    return ApiResponse<T>(
      data: fromJson?.call(map?['Data']),
      meta: ApiResponseMeta.fromJson(map?['Data']['Meta']),
    );
  }

  @override
  List<Object?> get props => [meta];
}

class ApiRespExeption extends Equatable implements Exception {
  const ApiRespExeption({
    required this.meta,
    this.data,
  });
  final ApiResponseMeta meta;
  final Map<String, dynamic>? data;

  factory ApiRespExeption.fromJson(Map<String, dynamic>? map) {
    return ApiRespExeption(
      meta: ApiResponseMeta.fromJson(map?['Data']['Meta']),
      data: map?['Data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Meta': meta.toJson(),
      'Data': data,
    };
  }

  factory ApiRespExeption.fromDioException(DioException exception) {
    var code = 0;
    var message = '';

    if (exception.response?.data != null) {
      final data = safeCastMap<Map<dynamic, dynamic>>(exception.response?.data);
      code = int.tryParse(safeCastString(data['code'])) ?? 0;
    }
    switch (exception.type) {
      case DioExceptionType.cancel:
        // message = 'Request to API server was cancelled';
        message = LocaleKeys.errorConnect.tr();
      case DioExceptionType.connectionTimeout:
        // message = 'Connection timeout with API server';
        message = LocaleKeys.errorConnect.tr();
      case DioExceptionType.receiveTimeout:
        // message = 'Receive timeout in connection with API server';
        message = LocaleKeys.errorConnect.tr();
      case DioExceptionType.badCertificate:
        // message = 'Request to API server with bad certificate';
        message = LocaleKeys.errorConnect.tr();
      case DioExceptionType.connectionError:
        message = LocaleKeys.errorConnect.tr();
      case DioExceptionType.sendTimeout:
        // message = 'Send timeout in connection with API server';
        message = LocaleKeys.errorConnect.tr();
      case DioExceptionType.badResponse:
        code = exception.response?.statusCode ?? 0;
        final error = exception.response?.data;
        final errMsg = error is String ? error : tryCast<String>(error['message']);
        switch (code) {
          case 400:
            message = errMsg ?? LocaleKeys.errorConnect.tr(); // 'Bad request';
          case 401:
            message = errMsg ?? LocaleKeys.errorConnect.tr(); // 'Unauthorized';
          case 403:
            message = errMsg ?? LocaleKeys.errorConnect.tr(); // 'Forbidden';
          case 404:
            message = errMsg ?? LocaleKeys.errorConnect.tr(); // 'Not found';
          case 420:
            message = errMsg ?? LocaleKeys.errorConnect.tr(); // 'Session Expired. Please LogIn again';
          case 500:
            message = errMsg ?? LocaleKeys.errorConnect.tr(); // 'Oops, something went wrong, please try again later';
          case 502:
            message = errMsg ?? LocaleKeys.errorConnect.tr(); // 'Server unavailable';
          default:
            message = LocaleKeys.commonError.tr();
            break;
        }
        if (error is Map && error['code'] != null) {
          code = int.tryParse('${error['code']}') ?? code;
        }
      case DioExceptionType.unknown:
        if (exception.message?.contains('SocketException') ?? false) {
          code = 0;
          message = LocaleKeys.errorConnect.tr();
          break;
        } else if (exception.message?.contains('HandshakeException') ?? false) {
          code = 0;
          message = LocaleKeys.errorConnect.tr(); // 'Response data not found';
          break;
        }
        message = LocaleKeys.commonError.tr();
    }
    return ApiRespExeption(
      meta: ApiResponseMeta(
        code: '$code',
        message: message,
        errors: ApiResponseMetaErrors(
          message: message,
        ),
      ),
    );
  }

  factory ApiRespExeption.fromException(Exception exception) {
    return ApiRespExeption(
      meta: ApiResponseMeta(
        code: '0',
        message: exception.toString(),
        errors: ApiResponseMetaErrors(
          message: exception.toString(),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [meta];
}
