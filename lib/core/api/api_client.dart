
import 'package:dio/dio.dart';

enum ApiMethod { get, post, multipart, delete, put, download }
/// API client
class ApiClient {
  late Dio dio;
  ApiClient(Dio _dio) {
    dio = _dio;
  }

  Map<String, dynamic>? _headers;
  String _authToken = '';

  restApiCall({
    /// url endpoint
    final String? endpoint,

    /// map query parameters
    final Map<String, String>? params,

    /// api method
    final ApiMethod? method,

    /// formdata data
    final FormData? formData,

    /// map request header
    final Map<String, dynamic>? mHeader,

    /// bool form url enocde
    final formUrlEncoded = false,

    /// string user token
    final String? token,
  }) async {
    try {
      _headers ??= {};
      _headers?['AUTHORIZATION'] = token ?? '';
      if (mHeader != null) {
        _headers?.addAll(mHeader);
      }

      switch (method) {
        case ApiMethod.get:
          return await dio.get(
            endpoint ?? '',
            queryParameters: params ?? {},
            options: Options(
              headers: _headers ?? {},
            ),
          );
        case ApiMethod.post:
          return await dio.post(
            endpoint ?? '',
            // queryParameters: params,
            data: params,
            options: Options(
              contentType: "application/x-www-form-urlencoded",
              headers: mHeader
            ),
          );
        case ApiMethod.multipart:
          return await dio.post(
            endpoint ?? '',
            data: formData,
            options: Options(
              headers: _headers ?? {},
            ),
          );
        case ApiMethod.delete:
          return await dio.delete(
            endpoint ?? '',
            queryParameters: params ?? {},
            options: Options(
              headers: _headers ?? {},
            ),
          );
        case ApiMethod.put:
          return await dio.put(
            endpoint ?? '',
            queryParameters: params ?? {},
            options: Options(
              headers: _headers ?? {},
            ),
          );
        default:
          return Exception("You have set wrong http method");
      }
    } on Exception catch (e) {
      return Exception(e);
    }
  }
}
