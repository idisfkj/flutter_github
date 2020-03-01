import 'package:flutter/material.dart';
import 'package:flutter_github/ui/followers/followers.dart';
import 'package:flutter_github/ui/home/home.dart';
import 'package:flutter_github/ui/login/login.dart';
import 'package:flutter_github/routes/app_routes.dart';
import 'package:flutter_github/ui/repos/repos.dart';
import 'package:flutter_github/ui/webview/webview.dart';
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
      initialRoute: welcomeRoute.routeName,
      routes: {
        welcomeRoute.routeName: (BuildContext context) => WelcomePage(),
        loginRoute.routeName: (BuildContext context) => LoginPage(),
        homeRoute.routeName: (BuildContext context) => HomePage(),
        repositoryRoute.routeName: (BuildContext context) => RepositoryPage(),
        followersRoute.routeName: (BuildContext context) =>
            FollowersPage(followersRoute.pageType),
        followingRoute.routeName: (BuildContext context) =>
            FollowersPage(followingRoute.pageType),
        webViewRoute.routeName: (BuildContext context) => WebViewPage(title: '',),
      },
    );
  }
}
