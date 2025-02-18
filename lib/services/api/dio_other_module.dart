import 'log_interceptor.dart' as log;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioOtherModule with DioMixin implements Dio {
  DioOtherModule._() {
    options = BaseOptions(
      contentType: 'application/json',
      connectTimeout: Duration(seconds: 30 * 1000),
      sendTimeout: Duration(seconds: 30 * 1000),
      receiveTimeout: Duration(seconds: 30 * 1000),
      followRedirects: true,
      receiveDataWhenStatusError: true,
      baseUrl: "https://nominatim.openstreetmap.org/search.php",
      headers: {'Accept': 'application/json'},
    );

    interceptors..add(log.LogInterceptor());

    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance() => DioOtherModule._();
}
