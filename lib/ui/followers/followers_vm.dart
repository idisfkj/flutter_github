import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:toast/toast.dart';

class FollowersVM extends BaseVM {
  BuildContext context;

  FollowersVM(this.context);

  Completer<String> _completer;

  @override
  void init() {
    _getFollowers();
  }

  _getFollowers({bool isRefresh = false}) {
    if (isRefresh) {
      _completer.complete('refreshing completed');
    }
    showLoading(false);
  }

  Future<void> handlerRefresh() {
    _completer = Completer();
    _getFollowers();
    return _completer.future.then((content) {
      Toast.show(content, context);
    });
  }
}
