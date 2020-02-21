import 'package:flutter_github/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

clearUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(SP_AUTHORIZATION);
  await prefs.remove(SP_ACCESS_TOKEN);
}
