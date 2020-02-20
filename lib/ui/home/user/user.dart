import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/model/user_model.dart';
import 'package:flutter_github/ui/home/user/user_vm.dart';

class UserTabPage extends StatefulWidget {
  const UserTabPage();

  @override
  _UserTabPageState createState() => _UserTabPageState();
}

class _UserTabPageState extends State<UserTabPage> {
  UserVM _vm;
  UserModel _userModel;

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
    _vm = UserVM(context);
    _vm.getUser().then((userModel) {
      setState(() {
        this._userModel = userModel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userModel == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 25.0),
                child: FadeInImage.assetNetwork(
                  image: _userModel?.avatarUrl ?? '',
                  placeholder: 'images/app_welcome.png',
                  width: 120.0,
                  height: 120,
                ),
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
        ],
      );
    }
  }
}
