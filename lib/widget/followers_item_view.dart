import 'package:flutter/material.dart';
import 'package:flutter_github/common/colors.dart';

class FollowersItemView extends StatelessWidget {
  final GestureTapCallback tapCallback;
  final String avatarUrl;
  final String name;

  const FollowersItemView(
      {Key key, this.avatarUrl, this.name, this.tapCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: tapCallback,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                FadeInImage.assetNetwork(
                  placeholder: 'images/app_welcome.png',
                  image: avatarUrl,
                  width: 80.0,
                  height: 80.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Divider(
                thickness: 1.0,
                color: colorEAEAEA,
                height: 1.0,
                endIndent: 0.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
