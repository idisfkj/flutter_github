import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/common/colors.dart';
import 'package:flutter_github/model/notification_model.dart';
import 'package:flutter_github/widget/text_with_side.dart';
import 'package:toast/toast.dart';

class RepositoryItemView extends StatelessWidget {
  final Repository _item;
  final GestureTapCallback tapCallback;

  RepositoryItemView(this._item, {this.tapCallback});

  final bottomInfoTextStyle =
      TextStyle(fontSize: 12.0, color: color_999, fontStyle: FontStyle.italic);

  _goToRepositoryDetail(BuildContext context) {
    return () {
      Toast.show('todo jump repository detail!', context);
    };
  }

  @override
  Widget build(BuildContext context) {
    final _licenseLength = _item.license?.name?.length ?? 0;
    final _license = _item.license?.name
            ?.substring(0, _licenseLength > 15 ? 15 : _licenseLength) ??
        '';
    final _nameLength = _item.name.length;
    final _name = _item.name.substring(0, _nameLength > 20 ? 20 : _nameLength);
    return GestureDetector(
      onTap: tapCallback ?? _goToRepositoryDetail(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  _name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 117, 243),
                  ),
                ),
                Visibility(
                  visible: _item.private,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    child: Text(
                      'private',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: color_666,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey[400]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                _item.description ?? '',
                style: TextStyle(
                  fontSize: 14.0,
                  color: color_666,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  _buildBottomInfo(_item?.language ?? '', 'images/circle.png',
                      _item.language?.isNotEmpty ?? false),
                  _buildBottomInfo(_item.stargazersCount.toString(),
                      'images/start.png', _item.stargazersCount > 0),
                  _buildBottomInfo(_item.forksCount.toString(),
                      'images/git_repo_forked.png', _item.forksCount > 0),
                  _buildBottomInfo(_license, 'images/license.png',
                      _item.license?.name?.isNotEmpty ?? false),
                  Expanded(
                    child: Text(
                      _updateAtContent(_item.updatedAt),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: bottomInfoTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Divider(
                thickness: 1.0,
                color: colorEAEAEA,
                height: 1.0,
                endIndent: 0.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomInfo(String content, String imagePath, bool visible) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: TextWithSide(
          side: Image.asset(
            imagePath,
            width: 12.0,
            height: 12.0,
          ),
          text: Text(
            content,
            style: bottomInfoTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          sideDistance: 5.0,
        ),
      ),
    );
  }

  _updateAtContent(String updateAt) {
    if (updateAt != null && updateAt.indexOf('T') >= 0) {
      return updateAt.substring(0, updateAt.indexOf('T'));
    }
    return '';
  }
}
