import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:toast/toast.dart';

import 'notification_vm.dart';

class NotificationPage extends BasePage<_NotificationPageState> {
  const NotificationPage();

  @override
  _NotificationPageState createBaseState() => _NotificationPageState();
}

class _NotificationPageState
    extends BaseState<NotificationVM, NotificationPage> {
  @override
  NotificationVM createVM() => NotificationVM();

  Future<void> _handlerRefresh() {
    final Completer<String> completer = Completer<String>();
    Timer(const Duration(seconds: 3), () {
      completer.complete('refresing success');
    });
    return completer.future.then((content) {
      Toast.show(content, context);
    });
  }

  static final List<String> _items = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
  ];

  @override
  Widget createContentWidget() {
    return RefreshIndicator(
      onRefresh: _handlerRefresh,
      child: Scrollbar(
        child: ListView.builder(
            padding: kMaterialListPadding,
            itemCount: _items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  child: Text(_items[index]),
                ),
                title: Text('This item represent ${_items[index]}'),
                subtitle: Text(
                    'Even more additional list item information appears on line three.'),
              );
            }),
      ),
    );
  }
}
