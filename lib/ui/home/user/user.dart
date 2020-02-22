import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/model/user_model.dart';
import 'package:flutter_github/ui/base/base_widget.dart';
import 'package:flutter_github/ui/home/user/user_vm.dart';

class UserTabPage extends StatefulWidget {
  const UserTabPage();

  @override
  _UserTabPageState createState() => _UserTabPageState();
}

class _UserTabPageState extends State<UserTabPage> {
  UserVM _vm;
  UserModel _userModel;
  bool _loading = true;

  Widget _buildUserImage() {
    if (_userModel == null) {
      return Image.asset(
        'images/app_welcome.png',
        width: 120.0,
        height: 120.0,
      );
    } else {
      return FadeInImage.assetNetwork(
        image: _userModel?.avatarUrl ?? '',
        placeholder: 'images/app_welcome.png',
        width: 120.0,
        height: 120.0,
      );
    }
  }

  Widget _buildContactWidget(int num, String category) {
    return Column(
      children: <Widget>[
        Text(
          '$num',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
          child: Text(
            category,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _vm = UserVM(context)
      ..getUser().then((userModel) {
        setState(() {
          _loading = false;
          _userModel = userModel;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      contentWidget: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 25.0),
                child: _buildUserImage(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, right: 15.0),
                      child: Text(
                        _userModel?.name ?? '',
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 15.0),
                      child: Text(
                        _userModel?.bio ?? '',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 15.0),
                      child: Text(
                        _userModel?.location ?? '',
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
            child: Divider(
              height: 1.0,
              color: Color.fromARGB(255, 207, 216, 220),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildContactWidget(_userModel?.publicRepos ?? 0, 'Repos'),
              _buildContactWidget(_userModel?.followers ?? 0, 'Followers'),
              _buildContactWidget(_userModel?.following ?? 0, 'Following')
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 25.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0)),
                  minWidth: 280.0,
                  height: 45.0,
                  child: Text(
                    'logout',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  onPressed: _vm.logout,
                ),
              ),
            ),
          ),
        ],
      ),
      showLoading: _loading,
    );
  }
}
