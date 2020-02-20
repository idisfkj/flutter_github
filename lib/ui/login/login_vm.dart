import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_github/common/constants.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/user_model.dart';
import 'package:flutter_github/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginVM {
  String username = '';
  String password = '';
  BuildContext context;

  LoginVM(this.context);

  signInOnPress() {
    if (username.trim().isEmpty || password.trim().isEmpty) {
      return null;
    } else {
      return () {
        FocusScope.of(context).requestFocus(FocusNode());
        _saveUserInfo();
      };
    }
  }

  _saveUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SP_USER_NAME, username);
    await prefs.setString(SP_PASSWORD, password);
    await prefs.setString(SP_AUTHORIZATION,
        base64Encode(ascii.encode(username + ':' + password)));
    _getUser();
  }

  _getUser() async {
    try {
      Response response = await dio.get('/user');
      UserModel userModel = UserModel.fromJson(response.data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(SP_USER_NAME, userModel.login);
      Toast.show('login success! hi ${userModel.name}', context);
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
    } on DioError catch (e) {
      Toast.show('getUser error: ${e.message}', context);
    }
  }

  authorization() {
    return () async {
      FocusScope.of(context).requestFocus(FocusNode());
      if (await canLaunch(URL_AUTHORIZATION)) {
        // 为设置forceSafariVC，IOS 默认会打开APP内部WebView
        // 而APP内部WebView不支持重定向跳转到APP
        await launch(URL_AUTHORIZATION, forceSafariVC: false);
      } else {
        throw 'Can not launch $URL_AUTHORIZATION)';
      }
    };
  }

  callLoginCode(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final platform = const MethodChannel(METHOD_CHANNEL_NAME);
      final code = await platform.invokeMethod(CALL_LOGIN_CODE);
      if (code != null) {
        _getAccessTokenFromCode(code);
      }
    }
  }

  _getAccessTokenFromCode(String code) async {
    try {
      Dio dio = Dio();
      dio.options.baseUrl = GITHUB_BASE_URL;
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 3000;
      Response response = await dio.post('/login/oauth/access_token',
          data: FormData.fromMap({
            'client_id': CLIENT_ID,
            'client_secret': CLIENT_SECRET,
            'code': code,
            'redirect_uri': REDIRECT_URI
          }));
      final token = response.data.toString().split("=")[1].split("&")[0];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(SP_ACCESS_TOKEN, token);
      await prefs.setString(SP_AUTHORIZATION, '');
      _getUser();
    } on DioError catch (e) {
      Toast.show('getAccessTokenFromCode DioError: ${e.message}', context);
    } on IOException catch (e) {
      Toast.show('getAccessTokenFromCode IOError: $e', context);
    }
  }
}
