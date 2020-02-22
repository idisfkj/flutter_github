import 'dart:async';
import 'package:flutter_github/ui/base/base_vm.dart';

class NotificationVM extends BaseVM {
  Timer _timer;

  @override
  void init() {
    _timer = Timer(const Duration(seconds: 3), () {
      showLoading(false);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }
}
