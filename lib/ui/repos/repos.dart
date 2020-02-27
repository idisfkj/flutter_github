import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:flutter_github/ui/repos/repos_vm.dart';

class RepositoryPage extends BasePage {
  @override
  _RepositoryState createBaseState() => _RepositoryState();
}

class _RepositoryState extends BaseState<RepositoryVM, RepositoryPage> {
  @override
  RepositoryVM createVM() => RepositoryVM(context);

  @override
  Widget createContentWidget() {
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        return null;
      },
    );
  }

  @override
  PreferredSizeWidget createAppBar() {
    return AppBar(
      title: Text('Repository'),
    );
  }
}
