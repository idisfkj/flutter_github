class AppRoutes {
  final String routeName;
  final String pageTitle;
  final String pageType;

  const AppRoutes(this.routeName, {this.pageTitle, this.pageType});
}

class PageType {
  static const String followers = 'followers';
  static const String following = 'following';
}

const AppRoutes welcomeRoute = AppRoutes('/');

const AppRoutes loginRoute = AppRoutes('/login');

const AppRoutes homeRoute = AppRoutes('/home');

const AppRoutes repositoryRoute =
    AppRoutes('/repository', pageTitle: 'repository');

const AppRoutes followersRoute = AppRoutes('/followers',
    pageTitle: 'followers', pageType: PageType.followers);
const AppRoutes followingRoute = AppRoutes('/following',
    pageTitle: 'following', pageType: PageType.following);

const AppRoutes webViewRoute = AppRoutes('/webview', pageTitle: 'WebView');
