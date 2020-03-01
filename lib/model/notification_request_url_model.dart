import 'package:flutter_github/model/user_model.dart';

class NotificationRequestUrlModel {
  String url;
  String html_url;
  UserModel userModel;
  String body;

  NotificationRequestUrlModel(
      {this.url, this.html_url, this.userModel, this.body});

  factory NotificationRequestUrlModel.fromJson(Map<String, dynamic> json) {
    return NotificationRequestUrlModel(
      url: json['url'],
      html_url: json['html_url'],
//      userModel: UserModel.fromJson(json['userModel']),
      body: json['body'],
    );
  }
}
