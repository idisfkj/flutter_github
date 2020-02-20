import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_github/routes/app_routes.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomeState createState() {
    return _WelcomeState();
  }
}

class _WelcomeState extends State<WelcomePage> {
  void _goToLogin() {
    Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      _goToLogin();
    });
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
