import 'package:flutter/cupertino.dart';
import 'package:flutter_github/ui/base/vm_s_contract.dart';

abstract class BaseVM {
  final BuildContext _context;

  BuildContext get context => _context;

  BaseVM(this._context);

  ValueChanged<bool> _showLoading;
  ValueChanged<bool> _loadingShowContent;
  VoidCallback _notifyStateChanged;

  ValueChanged<bool> get showLoading => _showLoading;

  ValueChanged<bool> get loadingShowContent => _loadingShowContent;

  VoidCallback get notifyStateChanged => _notifyStateChanged;

  void setupContract(VMSContract contract) {
    _showLoading = contract.getShowLoadingCallback();
    _loadingShowContent = contract.getLoadingShowContentCallback();
    _notifyStateChanged = contract.notifyStateChanged();
  }

  void init();

  void dispose() {}
}
