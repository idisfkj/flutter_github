

import 'package:flutter/cupertino.dart';

class TestText extends Text {

  final TextStyle style;

  TestText(String data, {this.style}) : super(data, style: style);

  @override
  Widget build(BuildContext context) {
    print("TestText build");
    return super.build(context);
  }

}