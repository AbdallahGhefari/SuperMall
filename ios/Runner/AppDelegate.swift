import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     // TODO: Add your Google Maps API key
        GMSServices.provideAPIKey("AIzaSyD8n9iNUrAoCZ8d-11E8AS6gra1woDT26o")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
