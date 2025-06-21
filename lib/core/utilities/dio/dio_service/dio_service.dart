import 'package:ansicolor/ansicolor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../../../apis/apis_endpoints/apis_endpoints.dart';
import '../../../di/injectable_initializer.dart';

@module
abstract class DioService {
  @preResolve
  Future<Dio> provideDio() async {
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          enabled: kDebugMode,
          printResponseHeaders: true,
          printRequestHeaders: true,
          printResponseTime: true,
          printResponseRedirects: true,
          // Blue http requests logs in console
          requestPen: AnsiPen()..white(),
          // Green http responses logs in console
          responsePen: AnsiPen()..green(),
          // Error http logs in console
          errorPen: AnsiPen()..red(),
        ),
      ),
    );
    return dio;
  }
}

extension DioServiceExtension on DioService {
  static void updateDioWithToken(String token) {
    Dio dio = getIt.get<Dio>();
    BaseOptions newBaseOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      headers: {
        "Authorization": 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    dio.options = newBaseOptions;
  }

  static void clearDefaultHeaders() {
    Dio dio = getIt.get<Dio>();
    dio.options.headers.clear();
  }

  static void setHeadersToDefault(String token) {
    Dio dio = getIt.get<Dio>();
    dio.options.headers = {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}
