//
//  OpenAppsController.swift
//  CWWG
//
//  Created by Alexander Zimin on 19/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class OpenAppsController {
  enum App: Int64 {
    case messenger = 1207352075
    case quiz = 1206998103
    
    var scheme: String {
      switch self {
      case .messenger:
        return "cwwgmessenger://"
      case .quiz:
        return "cwwgquiz://"
      }
    }
    
    var urlSheme: URL {
      return URL(string: scheme)!
    }
    
    var appStoreURL: URL {
      let urlString = "https://itunes.apple.com/app/id\(rawValue)"
      return URL(string: urlString)!
    }
  }
  
  static func open(app: App) {
    if UIApplication.shared.canOpenURL(app.urlSheme) {
      UIApplication.shared.openURL(app.urlSheme)
    } else {
      UIApplication.shared.openURL(app.appStoreURL)
    }
  }
}
