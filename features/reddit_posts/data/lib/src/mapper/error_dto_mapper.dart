import 'dart:io';

import 'package:common_domain/mapper/mapper.dart';
import 'package:dio/dio.dart';
import 'package:features_reddit_posts_domain/features_reddit_posts_domain.dart';

class ErrorDtoMapper extends Mapper<dynamic, ErrorModel> {
  @override
  ErrorModel map(dynamic input) {
    if (input is DioError) {
      switch (input.type) {
        case DioErrorType.response:
          if (input.response?.data case var data?) {
            if (data is Map<String, dynamic>) {
              return ErrorModel("${data["error"]} ${data["message"]}");
            } else {
              return ErrorModel(data);
            }
          }
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.cancel:
        case DioErrorType.other:
          final error = input.error;
          return ErrorModel(error is SocketException ? error.message : input.message);
      }
    }
    return ErrorModel(input.toString());
  }
}
