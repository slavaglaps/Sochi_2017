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

import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    Fabric.with([Crashlytics.self])
    DataModelController.setup()
    
    LocalizationController.loadLocalization()
    AppearanceController.setup()
    
    NetworkActivityIndicatorManager.shared.isEnabled = true
    NetworkActivityIndicatorManager.shared.startDelay = 0
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) {
        (granted, error) in
      }
      application.registerForRemoteNotifications()
    } else {
      UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
      UIApplication.shared.registerForRemoteNotifications()
    }
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    if LocalizationController.isLocalizationWasSelected {
      makeMenuRootViewController()
    } else {
      window?.rootViewController = ViewControllersFactory.selectLanguageController
      window?.makeKeyAndVisible()
    }
    
    return true
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    PushNotificationsController.registerNotification(withToken: deviceToken)
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    // Print the error to console (you should alert the user that registration failed)
    print("APNs registration failed: \(error)")
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
    // Print notification payload data
    print("Push notification received: \(data)")
  }

  func showNewsViewControllerAsRootViewController() {
    UIView.transition(with: self.window!, duration: 0.35, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
      self.makeMenuRootViewController()
    }, completion: nil)
  }
  
  func makeMenuRootViewController() {
    let navgationController = ViewControllersFactory.baseNavigationController(withRootViewController: ViewControllersFactory.scheduleViewController)
    
    let menu = ViewControllersFactory.menuViewController
    
    window?.rootViewController = navgationController
    window?.makeKeyAndVisible()
    
    navgationController.view.addSubview(menu.view)
    OperationQueue.main.addOperation({
      navgationController.present(menu, animated: false, completion: nil)
    })
    
    RouterController.shared.baseNavigationController = navgationController
  }
}

