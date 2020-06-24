# flutter_github

[![License](https://img.shields.io/badge/license-Apache%202-green.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![Platform](https://img.shields.io/badge/platform-android%20%7C%20ios-brightgreen)](https://flutter.dev/)
[![Language](https://img.shields.io/badge/language-dart-ff69b4)](https://dart.dev/)
[![Author](https://img.shields.io/badge/Author-idisfkj-orange.svg)](https://idisfkj.github.io/archives/)
[![Rating](https://img.shields.io/chrome-web-store/stars/nimelepbpejjlbmoobocpfnjhihnpked.svg)]()

在Android原生Github客户端[AwesomeGithub](https://github.com/idisfkj/AwesomeGithub)上同步开发出的基于Flutter的跨平台客户端。

Flutter Github客户端，同时支持Android与IOS，支持账户密码与认证登陆。使用dart语言进行开发，项目架构是基于Model/State/ViewModel的MSVM；使用Navigator进行页面的跳转；网络框架使用了dio。

如果你对Flutter怀有憧憬，或者你想更好的理解与掌握Flutter。请Clone下该项目，通过这个项目你将正式成为一名Flutter开发者。

项目持续更新中，为了防止走失，请做好start准备！😊😊

![flutter_github_preview](https://github.com/idisfkj/flutter_github/raw/master/images/flutter_github_preview.png)

### Doing
接下来的一段时间，我会对该项目中使用的技术进行逐一进行讲解，目的是为了对这个项目做全面的解析，不让读者产生一点疑惑。

- [x] [Flutter StatelessWidget](https://mp.weixin.qq.com/s?__biz=MzIzNTc5NDY4Nw==&mid=2247484222&idx=1&sn=d11adb51b2488310d0e99e85edad3929&chksm=e8e0faaedf9773b89b3db238ea978ab285055456ef127e550cad576cfe43e6ee646f3fb45b8e&token=288527406&lang=zh_CN#rd)
- [x] [Flutter StatefulWidget](https://mp.weixin.qq.com/s?__biz=MzIzNTc5NDY4Nw==&mid=2247484232&idx=1&sn=008d1782cefdd8555f2b95681b33f27a&chksm=e8e0fad8df9773ce71e2914bf4bb8510d8e6b16911cf3aef45eca95a939e0c297a162b061545&token=288527406&lang=zh_CN#rd)
- [x] [Flutter InheritedWidget](https://mp.weixin.qq.com/s?__biz=MzIzNTc5NDY4Nw==&mid=2247484244&idx=1&sn=08aadb3de199382bce2c9cd8ebb9fa1b&chksm=e8e0fac4df9773d2557bbe430577000814edb33fbb0ffb6060bd927056019b5ae50790afa3bd&token=288527406&lang=zh_CN#rd)
- [x] [Flutter Provider](https://mp.weixin.qq.com/s?__biz=MzIzNTc5NDY4Nw==&mid=2247484324&idx=1&sn=0f0fbf7af29369de207fae9188a2dcf8&chksm=e8e0fa34df977322113a3d47296a2a21a775fad419df8c802b42a33d1a8884bf68316b351eb0&token=288527406&lang=zh_CN#rd)
- [x] [Flutter Navigator](https://mp.weixin.qq.com/s?__biz=MzIzNTc5NDY4Nw==&mid=2247484403&idx=1&sn=469720c4cfadba6275756493209dec84&chksm=e8e0fa63df9773751eccc7233916be35e1d2edf3f8b6cb826ba30a54fe8d911fa728ee47da09&token=288527406&lang=zh_CN#rd)
- [ ] Flutter MethodChannel
- [ ] Flutter Dio
- [ ] Flutter Dialog
- [ ] Flutter MSVM
- [ ] Flutter ValueNotifier
- [ ] Flutter WebView

### Android纯原生版直通车

[AwesomeGithub](https://github.com/idisfkj/AwesomeGithub)

### Pubspec.yaml

```
version: 1.0.0+1

environment:
  sdk: ">=2.2.2 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  http: 0.12.0+4
  dio: 3.0.7
  shared_preferences: 0.5.6+1
  url_launcher: 5.4.1
  toast: 0.1.5
  webview_flutter: 0.3.19+8

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.2

```

## 加入我们

如需了解更多可以扫描下方二维码，加入我们：Android补给站。让我们与志同道合的你一起成长。

![关注](https://github.com/idisfkj/android-api-analysis/raw/master/image/wx.jpg)

