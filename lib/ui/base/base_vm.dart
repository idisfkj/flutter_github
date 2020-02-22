import 'package:flutter/cupertino.dart';
import 'package:flutter_github/ui/base/vm_s_contract.dart';

abstract class BaseVM {
  ValueChanged<bool> _showLoading;
  ValueChanged<bool> _loadingShowContent;

  ValueChanged<bool> get showLoading => _showLoading;

  ValueChanged<bool> get loadingShowContent => _loadingShowContent;

  void setupContract(VMSContract contract) {
    _showLoading = contract.getShowLoadingCallback();
    _loadingShowContent = contract.getLoadingShowContentCallback();
  }

  void init();

  void dispose() {}
}
