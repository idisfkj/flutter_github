import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final bool showLoading;
  final Widget contentWidget;
  final bool loadingShowContent;

  BasePage(
      {Key key,
      @required this.contentWidget,
      this.showLoading = true,
      this.loadingShowContent = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: !showLoading || loadingShowContent,
          child: contentWidget,
        ),
        Visibility(
          visible: showLoading,
          child: Center(
            child: Image.asset('images/loading.gif'),
          ),
        ),
      ],
    );
  }
}
