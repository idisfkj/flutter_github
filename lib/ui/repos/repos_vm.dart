import 'package:flutter/cupertino.dart';
import 'package:flutter_github/ui/base/base_vm.dart';

class RepositoryVM extends BaseVM {
  BuildContext context;

  RepositoryVM(this.context);

  @override
  void init() {
    showLoading(false);
  }


}
