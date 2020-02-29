import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/notification_model.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:toast/toast.dart';

class RepositoryVM extends BaseVM {
  List<Repository> _list;

  RepositoryVM(BuildContext context) : super(context);

  List<Repository> get list => _list;

  Completer<String> _completer;

  @override
  void init() {
    _getRepos();
  }

  _getRepos({bool isRefresh = false}) async {
    try {
      Response response = await dio.get('/user/repos',
          queryParameters: {'vivibility': 'all', 'sort': 'pushed'});
      _list = repositoryListFromJson(response.data);
    } on DioError catch (e) {
      Toast.show('getRepos Error ${e.message}', context);
    }
    if (isRefresh) _completer.complete('refreshing completed');
    showLoading(false);
  }

  Future<void> handlerRefresh() {
    _completer = Completer<String>();
    _getRepos(isRefresh: true);
    return _completer.future.then((content) {
      Toast.show(content, context);
    });
  }
}
