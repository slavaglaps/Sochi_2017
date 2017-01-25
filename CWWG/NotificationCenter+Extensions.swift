//
//  NotificationCenter+Extensions.swift
//  CWWG
//
//  Created by Alexander Zimin on 25/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation

@objc
protocol UpdateUINotificationObserver {
  func updateUI()
}

extension Notification.Name {
  static let UpdateUINotification = Notification.Name("UpdateUINotification")
}

extension NotificationCenter {
  func addUIObserver(observer: UpdateUINotificationObserver) {
    self.addObserver(observer, selector: #selector(observer.updateUI), name: NSNotification.Name.UpdateUINotification, object: nil)
    observer.updateUI()
  }
  
  func postUpdateUINotification() {
    self.post(name: NSNotification.Name.UpdateUINotification, object: nil)
  }
}
