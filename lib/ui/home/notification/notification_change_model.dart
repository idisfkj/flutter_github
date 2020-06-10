
import 'package:flutter/cupertino.dart';

class NotificationChangeModel extends ChangeNotifier {

  NotificationChangeModel(this._unread);

  bool get unread => _unread;

  bool _unread;

  void changeUnread(bool unread) {
    _unread = unread;
    notifyListeners();
  }

}