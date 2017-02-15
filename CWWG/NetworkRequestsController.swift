//
//  NetworkRequestsController.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let currentURL = "http://95.213.237.126:7777/api/v1/"
let pdfURL = URL(string: "http://95.213.237.126:7777/award/award_doc.pdf")!

struct NetworkRequestsController {
  static func sendTokenToServer(tokenString: String) {
    
    let url = stringURLFromPostfix(string: "push")
    let body = baseBodyPrametrs(withParametrs: ["pushToken": tokenString])
    
    request(url, method: .post, parameters: body).responseJSON { (data) in
      print(data)
    }
  }
  
  static func requstNews(lastId: Int = 0, limit: Int = 20, ascending: Bool, completionBlock: @escaping CompletionBlockForData) {
    
    let url = stringURLFromPostfix(string: "news")
    var body = ["pivot": lastId,
                "limit": limit,
                "ascending": ascending ? 1 : 0] as [String: Any]
    body = addLanguage(withParametrs: body)
    
    request(url, method: .get, parameters: body).responseJSON { (data) in
      if let data = data.data {
        let json = JSON(data: data)
        DataModelController.processNewsFromServer(json: json["news"], completionBlock: completionBlock)
      } else {
        completionBlock(false, false)
        print("Error loading news")
      }
    }
  }
  
  // MARK: - News
  
  static func requestNewsInfo(id: Int, completionBlock: @escaping CompletionBlock) {
    let url = stringURLFromPostfix(string: "news/\(id)")
    request(url, method: .get, parameters: nil).responseJSON { (data) in
      if let data = data.data {
        let json = JSON(data: data)
        DataModelController.updateNews(id: id, json: json["news"], completionBlock: completionBlock)
      } else {
        completionBlock(false)
        print("Error loading news from id")
      }
    }
  }
  
  // MARK: - Events
  
  static func requestEvents(completionBlock: @escaping CompletionBlock) {
    
    requestEventsTypes { (success) in
      guard success else {
        completionBlock(false)
        return
      }
     
      let url = stringURLFromPostfix(string: "schedule")
      
      // TODO: -- add last_update
      var body = ["last_update": 0] as [String: Any]
      body = addLanguage(withParametrs: body)
      
      request(url, method: .get, parameters: body).responseJSON { (data) in
        if let data = data.data {
          let json = JSON(data: data)
          DataModelController.processEvents(json: json)
          completionBlock(true)
        } else {
          completionBlock(false)
          print("Error loading events")
        }
      }
    }
  }
  
  static func requestEventsTypes(completionBlock: @escaping CompletionBlock) {
    let url = stringURLFromPostfix(string: "events")
    
    let body = addLanguage(withParametrs: [:])
    
    request(url, method: .get, parameters: body).responseJSON { (data) in
      if let data = data.data {
        let json = JSON(data: data)
        DataModelController.processEventTypes(json: json)
        completionBlock(true)
      } else {
        completionBlock(false)
        print("Error loading events tpyes")
      }
    }
  }
  
  // MARK: - Weather
  
  static func requestWeather(completionBlock: @escaping ((degree: Float, id: Int)?) -> Void) {
    let url = stringURLFromPostfix(string: "weather")
    let body = addLanguage(withParametrs: [:])
    
    request(url, method: .get, parameters: body).responseJSON { (data) in
      if let data = data.data {
        let json = JSON(data: data)
        if let degree = json["weather"]["temperature"].float, let id = json["weather"]["id"].int {
          completionBlock((degree, id))
        } else {
          completionBlock(nil)
        }
      } else {
        completionBlock(nil)
      }
    }
  }
  
  // MARK: - Contest Info
  
  static func requestContestResults(byId id: Int, completionBlock:  @escaping ([ContestResultEntity]?) -> Void) {
    let url = stringURLFromPostfix(string: "contests/\(id)")
    let body = addLanguage(withParametrs: [:])
    
    request(url, method: .get, parameters: body).responseJSON { (data) in
      if let data = data.data {
        let json = JSON(data: data)
        var results: [ContestResultEntity] = []
        for resultInfo in json["results"].arrayValue {
          let result = ContestResultEntity()
          result.id = id
          result.name = resultInfo["name"].stringValue
          result.points = resultInfo["points"].stringValue
          result.place = resultInfo["place"].intValue
          result.icon = resultInfo["icon"].stringValue
          results.append(result)
        }
        completionBlock(results)
      } else {
        completionBlock(nil)
      }
    }
  }
  
  // MARK: - Objecrts
  
  static func requestWhatIsGoingOnNow(completionBlock: @escaping CompletionBlock) {
    let url = stringURLFromPostfix(string: "objects/now")
    let body = addLanguage(withParametrs: [:])
    
    request(url, method: .get, parameters: body).responseJSON { (data) in
      if let data = data.data {
        let json = JSON(data: data)
        for objectInfo in json["objects"].arrayValue {
          let id = objectInfo["id"].intValue
          let object = ObjectRuntimeEntityContainer.findEntity(by: id)
          object?.event = objectInfo["now"].stringValue
        }
        completionBlock(true)
      } else {
        completionBlock(false)
      }
    }
  }
  
  // MARK: - Helpers
  
  private static func stringURLFromPostfix(string: String) -> String {
    return currentURL + string
  }
  
  private static func addLanguage(withParametrs parametrs: [String: Any]) -> [String: Any] {
    var result = parametrs
    result["lang"] = LocalizationController.currentLocalization.serverString
    return result
  }
  
  private static func baseBodyPrametrs(withParametrs parametrs: [String: Any]) -> [String: Any] {
    var result = parametrs
    let deviceId = AppConfiguration.deviceId
    
    result["deviceId"] = deviceId
    result["appId"] = 1
    result["deviceType"] = "ios"
    result["lang"] = LocalizationController.currentLocalization.serverString
    
    return result
  }
}
