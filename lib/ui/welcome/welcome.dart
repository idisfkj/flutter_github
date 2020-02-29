import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_github/common/constants.dart';
import 'package:flutter_github/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomeState createState() {
    return _WelcomeState();
  }
}

class _WelcomeState extends State<WelcomePage> {
  Timer _timer;

  void _goToLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authorization = prefs.getString(SP_AUTHORIZATION);
    String token = prefs.getString(SP_ACCESS_TOKEN);
    if ((authorization != null && authorization.isNotEmpty) ||
        (token != null && token.isNotEmpty)) {
      Navigator.pushReplacementNamed(context, homeRoute.routeName);
    } else {
      Navigator.pushReplacementNamed(context, loginRoute.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1500), () {
      _goToLogin();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return WillPopScope(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SafeArea(
              top: true,
              child: Offstage(),
            ),
          ),
          body: Container(
              width: width,
              height: height,
              child: GestureDetector(
                child: Image.asset('images/app_welcome.png'),
              ))),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }
}
