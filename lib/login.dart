import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_github/common/constants.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> with WidgetsBindingObserver {
  final _passwordFocusNode = FocusNode();
  final _usernameTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  AppLifecycleState _lastLifecycleState;

  String _username = '';
  String _password = '';

  _signInOnPress() {
    if (_username.trim().isEmpty || _password.trim().isEmpty) {
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
    await prefs.setString(SP_USER_NAME, _username);
    await prefs.setString(SP_PASSWORD, _password);
    await prefs.setString(SP_AUTHORIZATION,
        base64Encode(ascii.encode(_username + ':' + _password)));
    _getUser();
  }

  _getUser() async {
    try {
      Response response = await dio.get('/user');
      Toast.show('login success! hi ${UserModel.fromJson(response.data).name}',
          context);
    } on DioError catch (e) {
      Toast.show('getUser error: ${e.message}', context);
    }
  }

  _authorization() {
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _callLoginCode() async {
    // Android
    if (_lastLifecycleState == AppLifecycleState.resumed) {
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
      Toast.show('getAccessTokenFromCode error: ${e.message}', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _callLoginCode();
    return MaterialApp(
      title: 'Login',
      home: Scaffold(
          //防止因键盘弹出造成bottom overlowed by X pixels
          resizeToAvoidBottomPadding: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SafeArea(
              top: true,
              child: Offstage(),
            ),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Image.asset(
                    'images/app_welcome.png',
                    width: 100,
                    height: 83,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Sign in to Github',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 28, 49, 58)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 35.0, right: 35.0),
                  child: TextField(
                    controller: _usernameTextEditingController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Username or email address',
                    ),
                    onChanged: (content) {
                      setState(() {
                        _username = content;
                      });
                    },
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 35.0, right: 35.0),
                  child: TextField(
                    controller: _passwordTextEditingController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onChanged: (content) {
                      setState(() {
                        _password = content;
                      });
                    },
                    obscureText: true,
                    focusNode: _passwordFocusNode,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Color.fromARGB(255, 139, 195, 74),
                      focusColor: Color.fromARGB(255, 76, 145, 80),
                      disabledColor: Color.fromARGB(77, 139, 195, 74),
                      minWidth: 280.0,
                      height: 45.0,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      disabledTextColor: Colors.white,
                      textColor: Colors.white,
                      onPressed: _signInOnPress(),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Color.fromARGB(255, 3, 169, 244),
                      focusColor: Color.fromARGB(255, 0, 188, 211),
                      minWidth: 280.0,
                      height: 45.0,
                      child: Text(
                        'Authorize',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      textColor: Colors.white,
                      onPressed: _authorization(),
                    ))
              ],
            ),
          )),
    );
  }
}
