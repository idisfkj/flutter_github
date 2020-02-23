import 'package:flutter/cupertino.dart';

class VMSContract {
  ValueChanged<bool> getShowLoadingCallback() => (isShow) {};

  ValueChanged<bool> getLoadingShowContentCallback() => (isShow) {};

  VoidCallback notifyStateChanged() => () {};
}
