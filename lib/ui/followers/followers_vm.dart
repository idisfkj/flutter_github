import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/followers_model.dart';
import 'package:flutter_github/routes/app_routes.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:toast/toast.dart';

class FollowersVM extends BaseVM {
  final String _pageType;

  Completer<String> _completer;
  List<FollowersModel> _list;

  FollowersVM(BuildContext context, this._pageType) : super(context);

  List<FollowersModel> get list => _list;
  String _requestPath;

  @override
  void init() {
    _requestPath =
        _pageType == PageType.followers ? '/user/followers' : '/user/following';
    _getFollowers();
  }

  _getFollowers({bool isRefresh = false}) async {
    try {
      Response response = await dio.get(_requestPath);
      _list = followersModelListFromJson(response.data);
    } on DioError catch (e) {
      Toast.show('getFollowers error ${e.message}', context);
    }
    if (isRefresh) {
      _completer.complete('refreshing completed');
    }
    showLoading(false);
  }

  Future<void> handlerRefresh() {
    _completer = Completer();
    _getFollowers(isRefresh: true);
    return _completer.future.then((content) {
      Toast.show(content, context);
    });
  }
}
