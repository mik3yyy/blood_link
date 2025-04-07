import UIKit
import Flutter
import GoogleMaps
import UserNotifications  // Fix the module name

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAZ_tjIGq6-f7rjSlw8B2_EbRLQfGgCcw0")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Move the code inside a proper function scope
  override func applicationDidBecomeActive(_ application: UIApplication) {
    // Request notification permission
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      // Handle granting of permissions
    }
  }
}
