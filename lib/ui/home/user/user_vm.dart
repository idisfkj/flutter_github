import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/common/user_manager.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/user_model.dart';
import 'package:flutter_github/routes/app_routes.dart';
import 'package:toast/toast.dart';

class UserVM {
  BuildContext context;

  UserVM(this.context);

  Future<UserModel> getUser() async {
    try {
      Response response = await dio.get('/user');
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      // Unauthorized
      if (e.response.statusCode == 401) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute);
        Toast.show(
            'The authorized login has expired, please login again.', context,
            duration: 3);
      } else {
        Toast.show('getUser error: ${e.message}', context);
      }
      return null;
    }
  }

  logout() {
    _showLogoutDialog();
  }

  _showLogoutDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Logout',
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          content: const Text(
            'Are you sure to log out?',
            style: TextStyle(fontSize: 18.0, color: Colors.grey),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text(
                'Confirm',
                style: TextStyle(fontSize: 16.0),
              ),
              onPressed: () {
                clearUserInfo();
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
              },
            ),
            FlatButton(
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
