import 'package:flutter/cupertino.dart';

class TextWithSide extends StatelessWidget {
  final double sideDistance;
  final Widget side;
  final Text text;

  const TextWithSide(
      {Key key, this.sideDistance, @required this.side, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        side,
        Padding(
          padding: EdgeInsets.only(left: sideDistance),
          child: text,
        ),
      ],
    );
  }
}
