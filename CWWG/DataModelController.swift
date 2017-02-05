//
//  DAraModelController.swift
//  RealmPlay
//
//  Created by Alexander Zimin on 24/10/15.
//  Copyright © 2015 Alexander Zimin. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

typealias CompletionBlock = (_ success: Bool) -> ()
typealias CompletionBlockForData = (_ success: Bool, _ newData: Bool) -> ()

var defaultRealm: Realm?

class DataModelController {
  static func setup() {
    Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 2, migrationBlock: nil)
    do {
      defaultRealm = try Realm()
      writeFunction(block: { 
        defaultRealm!.delete(defaultRealm!.objects(NewsEntity.self))
      })
    }
    catch {
      assertionFailure("Default realm init error: \(error)")
    }
  }
  
  // MARK: - News
  
  static func processNewsFromServer(json: JSON, completionBlock: CompletionBlockForData) {
    var anythingNew = false
    
    for newsInfo in json.arrayValue {
      let id = newsInfo["id"].intValue
      
      anythingNew = true
      updateNews(id: id, json: newsInfo, completionBlock: nil)
    }
    
    completionBlock(true, anythingNew)
  }
  
  static func updateNews(id: Int, json: JSON, completionBlock: CompletionBlock?) {
    defer {
      completionBlock?(true)
    }
    
    let date = Date(serverString: json["updated_at"].stringValue)
    guard let dateValue = date, id > 0 else {
      return
    }
    
    let newsEntity = NewsEntity()
    newsEntity.title = json["title"].stringValue
    newsEntity.imageURL = json["photo"].string
    newsEntity.id = id
    newsEntity.dateOfCreation = dateValue
    newsEntity.text = json["text"].stringValue
    
    writeFunction(block: {
      defaultRealm?.add(newsEntity, update: true)
    })
  }
  
  // MARK: - Events
  
  static func processEvents(json: JSON, completionBlock: CompletionBlock) {
    for daysInfo in json.arrayValue {
      for itemInfo in daysInfo["items"].arrayValue {
        let id = itemInfo["id"].intValue
        updateEvent(id: id, json: itemInfo, completionBlock: nil)
      }
    }
    
    completionBlock(true)
  }
  
  static func updateEvent(id: Int, json: JSON, completionBlock: CompletionBlock?) {
    guard let startDate = Date(serverString: json["start"].stringValue), let endDate = Date(serverString: json["end"].stringValue) else {
      return
    }
    
    let newsEntity = EventEntity()
    newsEntity.id = id
    newsEntity.name = json["name"].stringValue
    newsEntity.startDate = startDate
    newsEntity.endDate = endDate
    newsEntity.objectId = json["game_object_id"].intValue
    newsEntity.isEvent = json["event"].boolValue
    newsEntity.dayString = json["day"].stringValue
    
    writeFunction(block: {
      defaultRealm?.add(newsEntity, update: true)
    })
  }
}
