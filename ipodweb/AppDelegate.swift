//
//  AppDelegate.swift
//  ipodweb
//

import UIKit

// Use @UIApplicationMain instead of @main for iOS 12 compatibility.
// @main is Swift 5.3+ and can misbehave on iOS 12 runtimes.
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Do NOT manually create UIWindow here — UIMainStoryboardFile in Info.plist
        // (set via INFOPLIST_KEY_UIMainStoryboardFile in the build settings) already
        // instantiates the window and root view controller automatically.
        // Doing it twice on iOS 12 races and leaves a blank white window.
        return true
    }
}
