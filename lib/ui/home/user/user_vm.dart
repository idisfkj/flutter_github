import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_github/common/constants.dart';
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
}
