import 'package:flutter/material.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:flutter_github/ui/followers/followers_vm.dart';
import 'package:flutter_github/widget/followers_item_view.dart';
import 'package:toast/toast.dart';

class FollowersPage extends BasePage {
  @override
  BaseState<BaseVM, StatefulWidget> createBaseState() => _FollowersState();
}

class _FollowersState extends BaseState<FollowersVM, FollowersPage> {
  @override
  PreferredSizeWidget createAppBar() {
    return AppBar(
      title: Text('Followers'),
      centerTitle: true,
    );
  }

  @override
  Widget createContentWidget() {
    return RefreshIndicator(
      onRefresh: vm.handlerRefresh,
      child: Scrollbar(
        child: ListView.builder(
            padding: EdgeInsets.only(top: 15.0),
            itemCount: vm.list?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final item = vm.list[index];
              return FollowersItemView(
                avatarUrl: item.avatar_url,
                name: item.login,
                tapCallback: () {
                  Toast.show(
                      'index of $index, todo jump followers detail', context);
                },
              );
            }),
      ),
    );
  }

  @override
  FollowersVM createVM() => FollowersVM(context);
}
