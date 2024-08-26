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
              return ErrorModel("${data["error"]} ${data["message"]}", ErrorModelType.badResponse);
            } else {
              return ErrorModel(data, ErrorModelType.badResponse);
            }
          }
          break;
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          final error = input.error;
          return ErrorModel(error is SocketException ? error.message : input.message, ErrorModelType.connectionError);
        case DioExceptionType.cancel:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          final error = input.error;
          return ErrorModel(error is SocketException ? error.message : input.message, ErrorModelType.unknown);
      }
    }
    return ErrorModel(input.toString(), ErrorModelType.unknown);
  }
}
