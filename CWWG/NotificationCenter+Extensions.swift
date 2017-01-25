//
//  NotificationCenter+Extensions.swift
//  CWWG
//
//  Created by Alexander Zimin on 25/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation

@objc
protocol UpdateLanguageNotificationObserver {
  func updateLanguage()
}

extension Notification.Name {
  static let UpdateLanguageNotification = Notification.Name("UpdateLanguageNotification")
}

extension NotificationCenter {
  func addLanguageChangeObserver(observer: UpdateLanguageNotificationObserver) {
    self.addObserver(observer, selector: #selector(observer.updateLanguage), name: NSNotification.Name.UpdateLanguageNotification, object: nil)
    observer.updateLanguage()
  }
  
  func postUpdateLanguageChangedNotification() {
    self.post(name: NSNotification.Name.UpdateLanguageNotification, object: nil)
  }
}
