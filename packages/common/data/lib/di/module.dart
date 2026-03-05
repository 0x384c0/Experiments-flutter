import 'package:common_data/client/curl_logger_dio_interceptor.dart';
import 'package:common_data/mapper/error_dto_mapper.dart';
import 'package:common_domain/data/error_model.dart';
import 'package:common_domain/mapper/mapper.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class CommonDataModule {
  @injectable
  Dio get dio {
    final dio = Dio();
    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    return dio;
  }

  @injectable
  Mapper<dynamic, ErrorModel> get errorDtoMapper => ErrorDtoMapper();
}
