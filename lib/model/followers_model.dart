List<FollowersModel> followersModelListFromJson(dynamic list) =>
    List<FollowersModel>.from(list.map((x) => FollowersModel.fromJson(x)));

class FollowersModel {
  String login;
  String avatar_url;
  String html_url;

  FollowersModel({this.login, this.avatar_url, this.html_url});

  factory FollowersModel.fromJson(Map<String, dynamic> json) => FollowersModel(
        login: json['login'],
        avatar_url: json['avatar_url'],
        html_url: json['html_url'],
      );
}
