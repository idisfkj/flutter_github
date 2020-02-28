import 'package:flutter/material.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:flutter_github/ui/followers/followers_vm.dart';

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
      child: ListView.builder(
          itemCount: 0,
          itemBuilder: (BuildContext context, int index) {
            return null;
          }),
    );
  }

  @override
  FollowersVM createVM() => FollowersVM(context);
}
