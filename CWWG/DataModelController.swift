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

var defaultRealm: Realm?

class DataModelController {
  static func setup() {
    Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1, migrationBlock: nil)
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
  
  static func processNewsFromServer(json: JSON, completionBlock: CompletionBlock) {
    for newsInfo in json.arrayValue {
      let id = newsInfo["id"].intValue
      updateNews(id: id, json: newsInfo, completionBlock: nil)
    }
    
    completionBlock(true)
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
}
