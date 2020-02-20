import 'package:flutter/material.dart';
import 'package:flutter_github/ui/home/home.dart';
import 'package:flutter_github/ui/login/login.dart';
import 'package:flutter_github/routes/app_routes.dart';
import 'welcome/welcome.dart';

class GithubApp extends StatefulWidget {
  @override
  _GithubAppState createState() {
    return _GithubAppState();
  }
}

class _GithubAppState extends State<GithubApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Github',
      theme: ThemeData.light(),
      initialRoute: AppRoutes.welcomeRoute,
      routes: {
        AppRoutes.welcomeRoute: (BuildContext context) => WelcomePage(),
        AppRoutes.loginRoute: (BuildContext context) => LoginPage(),
        AppRoutes.homeRoute: (BuildContext context) => HomePage()
      },
    );
  }
}
