//
//  NetworkRequestsController.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation
import Alamofire

let currentURL = "http://95.213.237.126:7777/api/v1/"

struct NetworkRequestsController {
  static func sendTokenToServer(tokenString: String) {
    
    let url = stringURLFromPostfix(string: "push")
    let body = baseBodyPrametrs(withParametrs: ["pushToken": tokenString])
    
    request(url, method: .post, parameters: body).responseJSON { (data) in
      print(data)
    }
  }
  
  // MARK: - Helpers
  
  private static func stringURLFromPostfix(string: String) -> String {
    return currentURL + string
  }
  
  private static func baseBodyPrametrs(withParametrs parametrs: [String: Any]) -> [String: Any] {
    var result = parametrs
    let deviceId = AppConfiguration.deviceId
    
    result["deviceId"] = deviceId
    result["appId"] = 1
    result["deviceType"] = "ios"
    
    return result
  }
}
