import 'package:flutter/material.dart';
import 'package:flutter_github/common/user_manager.dart';
import 'package:flutter_github/routes/app_routes.dart';

showLogoutDialog(BuildContext context) {
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
