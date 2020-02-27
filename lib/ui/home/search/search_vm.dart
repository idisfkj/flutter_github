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
    loadingShowContent(true);
    search('android-api-analysis');
  }

  search(String query) async {
    showLoading(true);
    try {
      Response response =
          await dio.get('/search/repositories', queryParameters: {'q': query});
      _searchModel = SearchModel.fromJson(response.data);
    } on DioError catch (e) {
      _searchModel = null;
      Toast.show('search error ${e.message}', context);
    }
    showLoading(false);
  }

}
