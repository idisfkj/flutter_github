import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/notification_model.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:flutter_github/ui/webview/webview.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'notification_change_model.dart';

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
      _notifications = List<NotificationModel>.from(
          response.data.map((x) => NotificationModel.fromJson(x)));
    } on DioError catch (e) {
      Toast.show('getNotification error: ${e.message}', context);
    }
    if (isRefresh) {
      _completer.complete('refresing completed');
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

  contentTap(int index, BuildContext context) {
    NotificationModel item = _notifications[index];
    if(item.unread) _markThreadRead(index, context);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return WebViewPage(
        title: item.subject?.title ?? '',
        requestUrl: item.subject?.url ?? '',
      );
    }));
  }

  _markThreadRead(int index, BuildContext context) async {
    try {
      Response response =
          await dio.patch('/notifications/threads/${_notifications[index].id}');
      if (response != null &&
          response.statusCode >= 200 &&
          response.statusCode < 300) {
        _notifications[index].unread = false;
        // 使用Provider进行通知子widget进行更新，避免widget树全局更新
        Provider.of<NotificationChangeModel>(context, listen: false).changeUnread(false);
//        notifyStateChanged();
      }
    } on DioError catch (e) {
      Toast.show('makThreadRead error: ${e.message}', context);
    }
  }
}
