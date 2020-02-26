import 'package:flutter/material.dart';
import 'package:flutter_github/common/colors.dart';
import 'package:flutter_github/model/notification_model.dart';
import 'package:flutter_github/model/search_model.dart';
import 'package:flutter_github/ui/base/base_page.dart';
import 'package:flutter_github/ui/base/base_state.dart';
import 'package:flutter_github/ui/home/search/search_vm.dart';
import 'package:flutter_github/widget/text_with_side.dart';
import 'package:toast/toast.dart';

class SearchTabPage extends BasePage {
  const SearchTabPage();

  @override
  _SearchPageState createBaseState() => _SearchPageState();
}

class _SearchPageState extends BaseState<SearchVM, SearchTabPage> {
  _SearchDelegate _delegate;

  @override
  void initState() {
    super.initState();
    _delegate = _SearchDelegate(vm);
  }

  @override
  SearchVM createVM() => SearchVM(context);

  @override
  Widget createContentWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, top: 5.0),
      child: IconButton(
        onPressed: () async {
          final Repository selected =
              await showSearch(context: context, delegate: _delegate);
          Toast.show(
              'search of ${selected?.name ?? ''}, to do jump repository detail',
              context);
        },
        icon: Icon(
          Icons.search,
          color: Colors.grey[700],
          size: 25.0,
        ),
      ),
    );
  }
}

class _SearchDelegate extends SearchDelegate<Repository> {
  SearchVM _searchVM;
  String _query;
  ValueNotifier<SearchModel> _searchModelNotifier;

  _SearchDelegate(this._searchVM) {
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
  Widget buildResults(BuildContext context) {
    if (_query != query || _searchVM.searchModel == null) {
      _query = query;
      _searchModelNotifier.value = null;
      _searchVM.search(query).then((success) {
        _searchModelNotifier.value = _searchVM.searchModel ?? SearchModel();
      });
    }
    return ValueListenableBuilder<SearchModel>(
      valueListenable: _searchModelNotifier,
      builder: (BuildContext context, SearchModel model, Widget child) {
        return model == null
            ? Center(
                child: Image.asset('images/loading.gif'),
              )
            : ListView.builder(
                padding: EdgeInsets.only(bottom: 10.0),
                itemCount: model?.items?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final _item = model.items[index];
                  final _licenseLength = _item.license?.name?.length ?? 0;
                  final _license = _item.license?.name?.substring(
                          0, _licenseLength > 15 ? 15 : _licenseLength) ??
                      '';
                  final _nameLength = _item.name.length;
                  final _name = _item.name
                      .substring(0, _nameLength > 20 ? 20 : _nameLength);
                  return GestureDetector(
                    onTap: () {
                      close(context, Repository(name: query));
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                _name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 33, 117, 243),
                                ),
                              ),
                              Visibility(
                                visible: _item.private,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 3.0),
                                  child: Text(
                                    'private',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: color_666,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.grey[400]),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              _item.description ?? '',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: color_666,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: <Widget>[
                                _buildBottomInfo(
                                    _item?.language ?? '',
                                    'images/circle.png',
                                    _item.language?.isNotEmpty ?? false),
                                _buildBottomInfo(
                                    _item.stargazersCount.toString(),
                                    'images/start.png',
                                    _item.stargazersCount > 0),
                                _buildBottomInfo(
                                    _item.forksCount.toString(),
                                    'images/git_repo_forked.png',
                                    _item.forksCount > 0),
                                _buildBottomInfo(_license, 'images/license.png',
                                    _item.license?.name?.isNotEmpty ?? false),
                                Expanded(
                                  child: Text(
                                    _searchVM.updateAtContent(_item.updatedAt),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: bottomInfoTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Divider(
                              thickness: 1.0,
                              color: colorEAEAEA,
                              height: 1.0,
                              endIndent: 0.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  Widget _buildBottomInfo(String content, String imagePath, bool visible) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: TextWithSide(
          side: Image.asset(
            imagePath,
            width: 12.0,
            height: 12.0,
          ),
          text: Text(
            content,
            style: bottomInfoTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          sideDistance: 5.0,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? ['aa', 'bb']
        : ['aaaaa', 'bbhj'].where((String i) => i.startsWith(query));
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
