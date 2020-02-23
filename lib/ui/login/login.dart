import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:flutter_github/ui/base/base_widget.dart';
import 'package:flutter_github/ui/login/login_vm.dart';

class LoginPage extends BasePage<_LoginState> {
  @override
  _LoginState createBaseState() => _LoginState();
}

class _LoginState extends BaseState<LoginVM, LoginPage>
    with WidgetsBindingObserver {
  final _passwordFocusNode = FocusNode();
  final _usernameTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  AppLifecycleState _lastLifecycleState;

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

  @override
  LoginVM createVM() => LoginVM(context);

  @override
  Widget createContentWidget() {
    vm.callLoginCode(_lastLifecycleState);
    return Center(
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
                  vm.username = content;
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
                  vm.password = content;
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
                onPressed: vm.signInOnPress(),
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
                onPressed: vm.authorization(),
              ))
        ],
      ),
    );
  }
}
