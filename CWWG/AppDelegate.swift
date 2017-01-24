//
//  AppDelegate.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit
import UserNotifications

import Fabric
import Crashlytics

var globalLogs: [String] = []

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    Fabric.with([Crashlytics.self])
    
    AppearanceController.setupAppearance()
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) {
        (granted, error) in
        globalLogs.append("\(granted, error)")
      }
      application.registerForRemoteNotifications()
    } else {
      UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
      UIApplication.shared.registerForRemoteNotifications()
    }
    
    return true
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    PushNotificationsController.registerNotification(withToken: deviceToken)
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    // Print the error to console (you should alert the user that registration failed)
    globalLogs.append("APNs registration failed: \(error)")
    print("APNs registration failed: \(error)")
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
    // Print notification payload data
    globalLogs.append("Push notification received: \(data)")
    print("Push notification received: \(data)")
  }

}

