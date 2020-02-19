import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var paramsMap: Dictionary<String, String> = [:]
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel.init(name: "app.channel.shared.data", binaryMessenger: controller.binaryMessenger)
    
    methodChannel.setMethodCallHandler { (call, result) in
        if "getLoginCode" == call.method && !self.paramsMap.isEmpty {
            result(self.paramsMap["code"])
            self.paramsMap.removeAll()
        }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let absoluteString = url.absoluteURL.absoluteString
        let urlComponents = NSURLComponents(string: absoluteString)
        let queryItems = urlComponents?.queryItems
        for item in queryItems! {
            paramsMap[item.name] = item.value
        }
        return true
    }
}
