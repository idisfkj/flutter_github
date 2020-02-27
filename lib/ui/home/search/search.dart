import 'package:flutter/material.dart';
import 'package:flutter_github/common/colors.dart';
import 'package:flutter_github/model/notification_model.dart';
import 'package:flutter_github/model/search_model.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:flutter_github/ui/home/search/search_vm.dart';
import 'package:flutter_github/widget/repository_item_view.dart';

class SearchTabPage extends BasePage {
  const SearchTabPage();

  @override
  _SearchPageState createBaseState() => _SearchPageState();
}

typedef SearchListWidget<SearchModel> = Widget Function(SearchModel);

class _SearchPageState extends BaseState<SearchVM, SearchTabPage> {
  _SearchDelegate _delegate;

  SearchListWidget<SearchModel> _getListWidget;

  @override
  void initState() {
    super.initState();
    _getListWidget = (model) {
      return ListView.builder(
        padding: EdgeInsets.only(bottom: 10.0),
        itemCount: model?.items?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return RepositoryItemView(model.items[index]);
        },
      );
    };
    _delegate = _SearchDelegate(vm, _getListWidget);
  }

  @override
  SearchVM createVM() => SearchVM(context);

  @override
  Widget createContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5.0, top: 5.0),
          child: IconButton(
            onPressed: () {
              showSearch(context: context, delegate: _delegate);
            },
            icon: Icon(
              Icons.search,
              color: Colors.grey[700],
              size: 25.0,
            ),
          ),
        ),
        Expanded(
          child: Scrollbar(
            child: _getListWidget(vm.searchModel),
          ),
        ),
      ],
    );
  }
}

class _SearchDelegate extends SearchDelegate<Repository> {
  SearchVM _searchVM;

//  String _query;
  ValueNotifier<SearchModel> _searchModelNotifier;
  SearchListWidget<SearchModel> _getSearchListWidget;
  final List<String> _hotSuggestionsList = const [
    'android-api-analysis',
    'AwesomeGithub',
    'flutter_github'
  ];
  List<String> _suggestionsList;
  final int _maxSuggestionsSize = 6;

  _SearchDelegate(this._searchVM, this._getSearchListWidget) {
    _searchModelNotifier = ValueNotifier<SearchModel>(_searchVM.searchModel);
  }

  final bottomInfoTextStyle =
      TextStyle(fontSize: 12.0, color: color_999, fontStyle: FontStyle.italic);

  @override
  List<Widget> buildActions(BuildContext context) {
    return query.isEmpty
        ? null
        : <Widget>[
            IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            ),
          ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    if (!_hotSuggestionsList.contains(query)) {
      if (_suggestionsList.contains(query)) {
        _suggestionsList.remove(query);
      }
      if (_suggestionsList.length >= _maxSuggestionsSize) {
        _suggestionsList.removeLast();
      }
      _suggestionsList.insert(_hotSuggestionsList.length, query);
    }
    _searchVM.search(query);
    close(context, null);
  }

  @override
  Widget buildResults(BuildContext context) {
//    if (_query != query || _searchVM.searchModel == null) {
//      _query = query;
//      _searchModelNotifier.value = null;
//      _searchVM.search(query).then((success) {
//        _searchModelNotifier.value = _searchVM.searchModel ?? SearchModel();
//      });
//    }
    return ValueListenableBuilder<SearchModel>(
      valueListenable: _searchModelNotifier,
      builder: (BuildContext context, SearchModel model, Widget child) {
        return model == null
            ? Center(
                child: Image.asset('images/loading.gif'),
              )
            : _getSearchListWidget(model);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (_suggestionsList == null) {
      _suggestionsList = [..._hotSuggestionsList];
    }
    final Iterable<String> suggestions = query.isEmpty
        ? _suggestionsList
        : _suggestionsList.where((String i) => i.startsWith(query));
    return _SuggestionList(
      query: query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestions) {
        query = suggestions;
        showResults(context);
      },
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
