import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/common/dialog.dart';
import 'package:flutter_github/common/user_manager.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/user_model.dart';
import 'package:flutter_github/routes/app_routes.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:toast/toast.dart';

class UserVM extends BaseVM {
  UserModel _userModel;

  UserVM(BuildContext context) : super(context);

  UserModel get userModel => _userModel;

  @override
  void init() {
    _getUser();
  }

  _getUser() async {
    try {
      Response response = await dio.get('/user');
      _userModel = UserModel.fromJson(response.data);
    } on DioError catch (e) {
      // Unauthorized
      if (e.response != null && e.response.statusCode == 401) {
        clearUserInfo();
        Navigator.of(context).pushReplacementNamed(loginRoute.routeName);
        Toast.show(
            'The authorized login has expired, please login again.', context,
            duration: 3);
      } else {
        Toast.show('getUser error: ${e.message}', context);
      }
    }
    showLoading(false);
  }

  logout() {
    showLogoutDialog(context);
  }
}
