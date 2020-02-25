import 'package:flutter_github/model/notification_model.dart';

class SearchModel {
  int totalCount;
  bool incompleteResult;
  List<Repository> items;

  SearchModel({this.totalCount, this.incompleteResult, this.items});

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        totalCount: json['total_count'],
        incompleteResult: json['incomplete_result'],
        items: repositoryListFromJson(json['items']),
      );
}
