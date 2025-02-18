import 'package:dio/dio.dart';
import '../../utils/shared_pref.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      var _token = await SharedPref.getString(SharedPref.accessToken);
      if (_token != "") options.headers['Authorization'] = 'Bearer $_token';
      handler.next(options);
    } catch (exception) {
      //
    }
  }

  @override
  void onError(DioError e, ErrorInterceptorHandler handler) {
    super.onError(e, handler);
    if (e.response != null) {
      if (e.response?.statusCode == 401) {
        _logoutExpiredToken();
      }
    }
  }

  _logoutExpiredToken() async {
    // BaseController _main = Get.find(tag: 'BaseController');
    // _main.logout();
  }
}
