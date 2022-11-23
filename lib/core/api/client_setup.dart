import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../core/api/api_interceptor.dart';
import '../../core/api/api_constant.dart';
import '../../flavors.dart';


/// dio client setup
setUpApiClient() {
  /// dio base options

  BaseOptions options = BaseOptions(
      baseUrl: F.baseUrl,
      receiveDataWhenStatusError: true,
      sendTimeout: 60 * 1000, //60 seconds
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000 // 60 seconds
      );

  Dio dio = Dio(options);

  /// dio interceptor

  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }
  
  dio.interceptors.add(AppInterceptors(dio));

  return dio;
}
