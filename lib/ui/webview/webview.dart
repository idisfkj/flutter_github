import 'package:flutter/material.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:flutter_github/ui/webview/webview_vm.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends BasePage<_WebViewState> {
  final String url;
  final String requestUrl;
  final String title;

  WebViewPage({@required this.title, this.url = '', this.requestUrl = ''});

  @override
  _WebViewState createBaseState() => _WebViewState(title, url, requestUrl);
}

class _WebViewState extends BaseState<WebViewVM, WebViewPage> {
  String _requestUrl;
  String _url;
  String _title;
  bool _canBack;

  WebViewController _controller;

  _WebViewState(this._title, this._url, this._requestUrl);

  @override
  PreferredSizeWidget createAppBar() {
    return AppBar(
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
  WebViewVM createVM() => WebViewVM(context, _requestUrl);
}
