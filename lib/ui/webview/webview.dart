import 'package:flutter/material.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:flutter_github/ui/webview/webview_vm.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends BasePage<_WebViewState> {
  static const String ARGS_TITLE = "title";
  static const String ARGS_REQUEST_URL = "request_Url";
  static const String ARGS_URL = "url";

  @override
  _WebViewState createBaseState() => _WebViewState();
}

class _WebViewState extends BaseState<WebViewVM, WebViewPage> {
  String _url;
  String _title;
  bool _canBack;

  WebViewController _controller;

  @override
  void didChangeDependencies() {
    Map<String, String> arguments = ModalRoute.of(context).settings.arguments;
    _title = arguments[WebViewPage.ARGS_TITLE];
    _url = arguments[WebViewPage.ARGS_URL];
    vm.requestUrl = arguments[WebViewPage.ARGS_REQUEST_URL];
    super.didChangeDependencies();
  }

  @override
  PreferredSizeWidget createAppBar() {
    return AppBar(
      backgroundColor: Colors.black87,
      title: Text(_title),
      centerTitle: true,
    );
  }

  @override
  Widget createContentWidget() {
    if ((_url?.isEmpty ?? true) && (vm.htmlUrl?.isEmpty ?? true)) {
      return Offstage();
    }
    return WillPopScope(
      child: WebView(
        initialUrl: vm.htmlUrl ?? _url,
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          vm.showLoading(false);
          _controller.canGoBack().then((canBack) {
            _canBack = canBack;
          });
        },
      ),
      onWillPop: () async {
        if (_canBack) _controller.goBack();
        return !_canBack;
      },
    );
  }

  @override
  WebViewVM createVM() => WebViewVM(context);
}
