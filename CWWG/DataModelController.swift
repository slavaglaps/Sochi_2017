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
    Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 9, migrationBlock: nil)
    do {
      defaultRealm = try Realm()
      writeFunction(block: {
        guard let realm = defaultRealm else { return }
        realm.delete(realm.objects(NewsEntity.self))
      })
    }
    catch {
      assertionFailure("Default realm init error: \(error)")
    }
  }
  
  static func clearLanguageModel() {
    writeFunction(block: {
      guard let realm = defaultRealm else { return }
      realm.delete(realm.objects(NewsEntity.self))
      realm.delete(realm.objects(EventEntity.self))
      realm.delete(realm.objects(EventTypeEntity.self))
      realm.delete(realm.objects(ObjectEntity.self))
      realm.delete(realm.objects(ContestEntity.self))
    })
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
  
  static func processEventTypes(json: JSON) {
    
    if (json["errors"].bool ?? true) == true {
      return
    }
    
    if let realm = defaultRealm {
      writeFunction {
        realm.delete(realm.objects(EventTypeEntity.self))
        realm.delete(realm.objects(ContestEntity.self))
      }
    }
    
    for itemInfo in json["events"].arrayValue {
      let id = itemInfo["id"].intValue
      let event = updateEventType(id: id, json: itemInfo)
      for contestInfo in itemInfo["contests"].arrayValue {
        let contest = updateConstest(json: contestInfo)
        writeFunction {
          event.contests.append(contest)
        }
      }
    }
  }
  
  static func updateEventType(id: Int, json: JSON) -> EventTypeEntity {
    let newsEntity = EventTypeEntity()
    
    newsEntity.id = id
    newsEntity.name = json["name"].stringValue
    
    writeFunction(block: {
      defaultRealm?.add(newsEntity, update: true)
    })
    
    return newsEntity
  }
  
  static func updateConstest(json: JSON) -> ContestEntity {
    let id = json["id"].intValue
    let name = json["name"].stringValue
    
    let contestEntity = ContestEntity()
    contestEntity.id = id
    contestEntity.name = name
    
    writeFunction(block: {
      defaultRealm?.add(contestEntity, update: true)
    })
    
    return contestEntity
  }
  
  static func processEvents(json: JSON) {
    for daysInfo in json.arrayValue {
      for itemInfo in daysInfo["items"].arrayValue {
        let id = itemInfo["id"].intValue
        updateEvent(id: id, json: itemInfo)
      }
    }
  }
  
  static func updateEvent(id: Int, json: JSON) {
    guard let startDate = Date(serverString: json["start"].stringValue), let endDate = Date(serverString: json["end"].stringValue) else {
      return
    }
    
    let newsEntity = EventEntity()
    newsEntity.id = id
    newsEntity.name = json["name"].stringValue
    newsEntity.startDate = startDate
    newsEntity.endDate = endDate
    newsEntity.objectId = json["game_object_id"].intValue
    newsEntity.eventTypeId = json["event_id"].intValue
    newsEntity.dayString = json["day"].stringValue
    
    writeFunction(block: {
      defaultRealm?.add(newsEntity, update: true)
    })
  }
}
