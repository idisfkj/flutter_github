import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_github/http/http.dart';
import 'package:flutter_github/model/search_model.dart';
import 'package:flutter_github/ui/base/base_vm.dart';
import 'package:toast/toast.dart';

class SearchVM extends BaseVM {
  BuildContext context;

  SearchVM(this.context);

  SearchModel _searchModel;

  SearchModel get searchModel => _searchModel;

  @override
  void init() {
    showLoading(false);
  }

  Future<bool> search(String query) async {
    showLoading(true);
    try {
      Response response =
          await dio.get('/search/repositories', queryParameters: {'q': query});
      _searchModel = SearchModel.fromJson(response.data);
      Toast.show('search ${_searchModel.items[0].name}', context);
      return true;
    } on DioError catch (e) {
      Toast.show('search error ${e.message}', context);
    }
    showLoading(false);
    return false;
  }

  updateAtContent(String updateAt) {
    if (updateAt != null && updateAt.indexOf('T') >= 0) {
      return updateAt.substring(0, updateAt.indexOf('T'));
    }
    return '';
  }
}
