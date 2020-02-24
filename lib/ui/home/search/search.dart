import 'package:flutter/material.dart';
import 'package:flutter_github/common/colors.dart';
import 'package:flutter_github/model/notification_model.dart';
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
  final SearchDelegate _delegate = _SearchDelegate();

  @override
  SearchVM createVM() => SearchVM();

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
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 10.0),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            close(context, Repository(name: query));
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'AwesomeGithub',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 33, 117, 243),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      child: Text(
                        'private',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: color_666,
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey[400]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'AwesomeGithub App',
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
                      _buildBottomInfo('kotlin', 'images/circle.png'),
                      _buildBottomInfo('100', 'images/start.png'),
                      _buildBottomInfo('99', 'images/git_repo_forked.png'),
                      _buildBottomInfo('License 2.0', 'images/license.png'),
                      Text(
                        '2019-11-05T15:57:00Z',
                        style: bottomInfoTextStyle,
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
  }

  Widget _buildBottomInfo(String content, String imagePath) {
    return Visibility(
      visible: true,
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
