import 'package:dld/constants/endpoints.dart';
import 'log_interceptor.dart' as log;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'api_interceptor.dart';

class DioModule with DioMixin implements Dio {
  DioModule._() {
    options = BaseOptions(
      contentType: 'application/json',
      connectTimeout: Duration(seconds: 30 * 1000),
      sendTimeout: Duration(seconds: 30 * 1000),
      receiveTimeout: Duration(seconds: 30 * 1000),
      followRedirects: true,
      receiveDataWhenStatusError: true,
      baseUrl: Endpoint.baseUrl,
      headers: {'Accept': 'application/json'},
    );

    interceptors
      ..add(ApiInterceptor())
      ..add(log.LogInterceptor());

    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance() => DioModule._();
}
