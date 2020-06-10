import 'package:flutter/cupertino.dart';

class TestGestureDetector extends GestureDetector {

  final GestureTapCallback onTap;
  final Widget child;

  TestGestureDetector({this.onTap, this.child})
      :super(onTap: onTap, child: child);

  @override
  Widget build(BuildContext context) {
    print("TestGestureDetector build");
    return super.build(context);
  }
}