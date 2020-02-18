import 'package:dio/dio.dart';
import 'package:flutter_github/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authorization = prefs.getString(SP_AUTHORIZATION);
    options.headers['Authorization'] =
        authorization.isNotEmpty ? 'Basic ' + authorization : 'token ' + '';
    print('onRequest: ${options.headers}');
    return options;
  }

  @override
  Future onResponse(Response response) {
    print('onResponse ${response.headers}');
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print('Network request onError ${err.request.uri}, ${err.message}');
    return super.onError(err);
  }
}
