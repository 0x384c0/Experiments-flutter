import 'dart:io';

import 'package:common_domain/mapper/mapper.dart';
import 'package:dio/dio.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

class ErrorDtoMapper extends Mapper<dynamic, ErrorModel> {
  @override
  ErrorModel map(dynamic input) {
    if (input is DioException) {
      switch (input.type) {
        case DioExceptionType.badResponse:
          if (input.response?.data case var data?) {
            if (data is Map<String, dynamic>) {
              return ErrorModel("${data["error"]} ${data["message"]}");
            } else {
              return ErrorModel(data);
            }
          }
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          final error = input.error;
          return ErrorModel(error is SocketException ? error.message : input.message);
      }
    }
    return ErrorModel(input.toString());
  }
}
