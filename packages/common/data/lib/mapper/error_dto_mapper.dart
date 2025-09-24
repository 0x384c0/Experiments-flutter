import 'dart:io';

import 'package:common_domain/data/error_model.dart';
import 'package:common_domain/mapper/mapper.dart';
import 'package:dio/dio.dart';

class ErrorDtoMapper extends Mapper<dynamic, ErrorModel> {
  @override
  ErrorModel map(dynamic input) {
    if (input is DioException) {
      switch (input.type) {
        case DioExceptionType.badResponse:
          if (input.response?.data case var data?) {
            if (data is Map<String, dynamic>) {
              return ErrorModel(
                message: "${data["error"] ?? data["message"] ?? data["title"]}",
                type: ErrorModelType.badResponse,
                code: input.response?.statusCode,
              );
            } else {
              return ErrorModel(
                message: data,
                type: ErrorModelType.badResponse,
                code: input.response?.statusCode,
              );
            }
          }
          break;
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          final error = input.error;
          return ErrorModel(
            message: error is SocketException ? error.message : input.message,
            type: ErrorModelType.connectionError,
          );
        case DioExceptionType.cancel:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          final error = input.error;
          String? message;
          if (error is SocketException) {
            message = error.message;
          } else if (error is HttpException) {
            message = error.message;
          } else if (input.message?.isNotEmpty == true) {
            message = input.message;
          } else {
            message = input.toString();
          }
          return ErrorModel(
            message: message,
            type: ErrorModelType.unknown,
          );
      }
    }
    return ErrorModel(
      message: input.toString(),
      type: ErrorModelType.unknown,
    );
  }
}
