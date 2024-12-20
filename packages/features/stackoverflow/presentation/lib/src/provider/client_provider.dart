import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final clientProvider = Provider((ref) => Dio());
