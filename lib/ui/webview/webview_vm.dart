import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/notification_request_url_model.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:toast/toast.dart';

class WebViewVM extends BaseVM {
  String _requestUrl;

  set requestUrl(String requestUrl) {
    _requestUrl = requestUrl;
  }

  String _htmlUrl;

  String get htmlUrl => _htmlUrl;

  WebViewVM(BuildContext context) : super(context);

  @override
  void didChangeDependencies() {
    loadingShowContent(true);
    if (!(_requestUrl?.isEmpty ?? true) && ModalRoute.of(context).isActive) {
      _getNotificationRequestUrl();
    }
  }

  @override
  void init() {}

  _getNotificationRequestUrl() async {
    try {
      if (_requestUrl.startsWith(API_GITHUB_BASE_URL)) {
        _requestUrl = _requestUrl.substring(API_GITHUB_BASE_URL.length + 1);
      }
      Response response = await dio.get('/$_requestUrl');
      _htmlUrl = NotificationRequestUrlModel.fromJson(response.data)?.html_url ?? '';
      notifyStateChanged();
    } on DioError catch (e) {
      Toast.show('getNotificationRequestUrl error ${e.message}', context);
      showLoading(false);
    }
  }
}
