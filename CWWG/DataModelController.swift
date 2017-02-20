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

var commonRealm: Realm?
var defaultRealm: Realm?

class DataModelController {
  static func setup() {
    Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 12, migrationBlock: nil)
    do {
      commonRealm = try Realm()
      switchDatabase(localization: LocalizationController.currentLocalization)
      
      writeFunction(block: {
        guard let realm = defaultRealm else { return }
        realm.objects(NewsEntity.self).setValue(false, forKey: #keyPath(NewsEntity.isInCurrentSession))
      })
    }
    catch {
      assertionFailure("Common realm init error: \(error)")
    }
  }
  
  static func switchDatabase(localization: LocalizationController.Localization) {
    let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    if let documentDirectory = directory.first {
      let finalDatabaseURL = documentDirectory.appendingPathComponent("\(localization.rawValue).db")
      let config = Realm.Configuration(fileURL: finalDatabaseURL, schemaVersion: 1)
      do {
        
        writeFunction(block: {
          guard let realm = defaultRealm else { return }
          realm.objects(NewsEntity.self).setValue(false, forKey: #keyPath(NewsEntity.isInCurrentSession))
        })
        
        defaultRealm = try Realm(configuration: config)
      }
      catch {
        assertionFailure("Default realm init error: \(error)")
      }
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
    newsEntity.isInCurrentSession = true
    newsEntity.dateOfCreation = dateValue
    newsEntity.text = json["text"].stringValue
    
    writeFunction(block: {
      defaultRealm?.add(newsEntity, update: true)
    })
    
    // Updating news description
    if (newsEntity.text ?? "").isEmpty {
      NetworkRequestsController.requestNewsInfo(id: id, completionBlock: { (success) in
        
      })
    }
  }
  
  // MARK: - Events
  
  static func processEventTypes(json: JSON) {
    
    if !isSuccess(json: json) {
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
    
    if json.arrayValue.count == 0 {
      return
    }
    
    if let realm = defaultRealm {
      writeFunction {
        realm.delete(realm.objects(EventEntity.self))
      }
    }
    
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
    newsEntity.contestId = json["contest_id"].intValue
    
    writeFunction(block: {
      defaultRealm?.add(newsEntity, update: true)
    })
  }
  
  private static func isSuccess(json: JSON) -> Bool {
    if let value = json["errors"].bool {
      return !value
    }
    return false
  }
  
  // MARK: - Pdf
  
  static func updatePdf(data: Data) {
    UserDefaults.standard.set(data, forKey: "CISM_medals_ru")
  }
  
  static func loadPdf() -> Data? {
    return UserDefaults.standard.object(forKey: "CISM_medals_ru") as? Data
  }
}
