//
//  AppConfiguration.swift
//  Target-App
//
//  Created by Alex Zimin on 04/04/15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import UIKit

class AppConfiguration: NSObject {
  class var appId: Int {
    return 1096787850
  }
  
  class var deviceId: String {
    return UIDevice.current.identifierForVendor?.uuidString ?? ""
  }
  
  class var appIdString: String {
    return "\(appId)"
  }
  
  class var appURL: NSURL {
    return NSURL(string:"http://itunes.apple.com/app/id\(appIdString)")!
  }
  
  class var appStoreOpenURL: NSURL {
    return NSURL(string:"itms-apps://itunes.apple.com/app/id\(appIdString)")!
  }
  
  class var contactURL: NSURL {
    return NSURL(string: "https://twitter.com/TrickyCircle")!
  }
  
  class var bundleIdentifier: String {
    return Bundle.main.bundleIdentifier ?? ""
  }
  
  class var versionString: String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0.0"
  }
  
  class var fullVersionString: String {
    return "\(versionString).\(buildNumberString)"
  }
  
  class var appVersion: CGFloat {
    return CGFloat((versionString as NSString).floatValue)
  }
  
  class var buildNumberString: String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0"
  }
  
  class var buildNumber: Int {
    return Int(buildNumberString) ?? 0
  }
}
