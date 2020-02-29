import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/notification_model.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:toast/toast.dart';

class NotificationVM extends BaseVM {
  List<NotificationModel> _notifications;

  List<NotificationModel> get notifications => _notifications;

  NotificationVM(BuildContext context) : super(context);

  Completer<String> _completer;

  static const String PULL_REQUEST = 'images/pull_request.png';
  static const String ISSUE_OPEN = 'images/issue_open.png';
  static const String ISSUE_CLOSED = 'images/issue_closed.png';

  @override
  void init() {
    _getNotification();
  }

  Future<void> handlerRefresh() {
    _completer = Completer<String>();
    _getNotification(isRefresh: true);
    return _completer.future.then((content) {
      Toast.show(content, context);
    });
  }

  _getNotification(
      {bool isRefresh = false,
      bool all = true,
      bool participating = false,
      String since = '',
      String before = ''}) async {
    try {
      Response response = await dio.get('/notifications', queryParameters: {
        'all': true,
        'participating': false,
        'since': since,
        'before': before
      });
      if (isRefresh) {
        _completer.complete('refresing completed');
      }
      _notifications = List<NotificationModel>.from(
          response.data.map((x) => NotificationModel.fromJson(x)));
    } on DioError catch (e) {
      Toast.show('getNotification error: ${e.message}', context);
    }
    showLoading(false);
  }

  String getTypeFlagSrc(String type) {
    if (type == "PullRequest") {
      return PULL_REQUEST;
    } else if (type == "Issue") {
      return ISSUE_OPEN;
    }
    return ISSUE_CLOSED;
  }

  contentTap(int index) {
    _markThreadRead(index);
    Toast.show(
        'id of ${_notifications[index].id}, to do jump to notification detail page.',
        context);
  }

  _markThreadRead(int index) async {
    try {
      Response response =
          await dio.patch('/notifications/threads/${_notifications[index].id}');
      if (response != null &&
          response.statusCode >= 200 &&
          response.statusCode < 300) {
        _notifications[index].unread = false;
        notifyStateChanged();
      }
    } on DioError catch (e) {
      Toast.show('makThreadRead error: ${e.message}', context);
    }
  }
}
