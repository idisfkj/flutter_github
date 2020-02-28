import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/followers_model.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:toast/toast.dart';

class FollowersVM extends BaseVM {
  BuildContext context;

  FollowersVM(this.context);

  Completer<String> _completer;
  List<FollowersModel> _list;

  List<FollowersModel> get list => _list;

  @override
  void init() {
    _getFollowers();
  }

  _getFollowers({bool isRefresh = false}) async {
    try {
      Response response = await dio.get('/user/followers');
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
