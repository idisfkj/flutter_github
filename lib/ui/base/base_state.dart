import 'package:flutter/cupertino.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:flutter_github/ui/base/base_widget.dart';
import 'package:flutter_github/ui/base/vm_s_contract.dart';

abstract class BaseState<VM extends BaseVM, T extends StatefulWidget>
    extends State implements VMSContract {
  VM _vm;
  bool _showLoading = true;
  bool _loadingShowContent = false;

  VM get vm => _vm;

  VM createVM();

  @override
  getShowLoadingCallback() {
    return (isShow) {
      setState(() {
        _showLoading = isShow;
      });
    };
  }

  @override
  getLoadingShowContentCallback() {
    return (isShow) {
      setState(() {
        _loadingShowContent = isShow;
      });
    };
  }

  @override
  notifyStateChanged() {
    return () {
      setState(() {});
    };
  }

  @override
  void initState() {
    super.initState();
    _vm = createVM()
      ..setupContract(this)
      ..init();
  }

  Widget createContentWidget();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      contentWidget: createContentWidget(),
      showLoading: _showLoading,
      loadingShowContent: _loadingShowContent,
    );
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }
}
