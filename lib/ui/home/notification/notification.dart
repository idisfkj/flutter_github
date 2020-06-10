import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/model/notification_model.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:flutter_github/ui/home/notification/notification_change_model.dart';
import 'package:provider/provider.dart';

import 'notification_vm.dart';

class NotificationTabPage extends BasePage<_NotificationPageState> {
  const NotificationTabPage();

  @override
  _NotificationPageState createBaseState() => _NotificationPageState();
}

class _NotificationPageState
    extends BaseState<NotificationVM, NotificationTabPage> {
  @override
  NotificationVM createVM() => NotificationVM(context);

  @override
  Widget createContentWidget() {
    return RefreshIndicator(
      onRefresh: vm.handlerRefresh,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: vm.notifications?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final NotificationModel item = vm.notifications[index];
            return ChangeNotifierProvider<NotificationChangeModel>(
              create: (context) => NotificationChangeModel(item.unread),
              child: Consumer<NotificationChangeModel>(
                builder: (context, item, child) => GestureDetector(
                  onTap: () {
                    vm.contentTap(index, context);
                  },
                  child: Container(
                      color: item.unread
                          ? Colors.white
                          : Color.fromARGB(13, 0, 0, 0),
                      padding:
                          EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
                      child: child),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.repository.fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: item.unread
                            ? Colors.black87
                            : Color.fromARGB(255, 102, 102, 102),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Image.asset(
                            vm.getTypeFlagSrc(item.subject.type),
                            width: 18.0,
                            height: 18.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.0, left: 10.0),
                            child: Text(
                              item.subject.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: item.unread
                                    ? Color.fromARGB(255, 17, 17, 17)
                                    : Color.fromARGB(255, 102, 102, 102),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Divider(
                        height: 1.0,
                        endIndent: 0.0,
                        color: Color.fromARGB(255, 207, 216, 220),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
