import 'package:flutter/material.dart';
import 'package:flutter_github/routes/app_routes.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:flutter_github/ui/followers/followers_vm.dart';
import 'package:flutter_github/ui/webview/webview.dart';
import 'package:flutter_github/widget/followers_item_view.dart';

class FollowersPage extends BasePage {
  final String _pageType;

  FollowersPage(this._pageType);

  @override
  BaseState<BaseVM, StatefulWidget> createBaseState() =>
      _FollowersState(this._pageType);
}

class _FollowersState extends BaseState<FollowersVM, FollowersPage> {
  final String _pageType;

  _FollowersState(this._pageType);

  @override
  PreferredSizeWidget createAppBar() {
    return AppBar(
      title: Text(_pageType == PageType.followers
          ? followersRoute.pageTitle
          : followingRoute.pageTitle),
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return WebViewPage(title: item.login, url: item.html_url);
                  }));
                },
              );
            }),
      ),
    );
  }

  @override
  FollowersVM createVM() => FollowersVM(context, _pageType);
}
