//
//  EventEntity.swift
//  CWWG
//
//  Created by Alexander Zimin on 04/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit
import RealmSwift

class EventEntity: Object {
  dynamic var id: Int = 0
  dynamic var startDate: Date = Date()
  dynamic var endDate: Date = Date()
  dynamic var objectId: Int = 0
  dynamic var name: String = ""
  dynamic var dayString: String = ""
  dynamic var eventTypeId: Int = 0
  
  var eventType: EventTypeEntity {
    let event = defaultRealm?.objects(EventTypeEntity.self).filter("id = \(eventTypeId)").first ?? EventTypeEntity.defaultEntity(withId: eventTypeId)
    return event
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  var image: UIImage {
    return UIImage(named: "img_sport_1")!
  }
  
  var timeIntervalString: String {
    return "\(startDate.hoursAndMinutes) - \(endDate.hoursAndMinutes)"
  }
  
  static func fakeData() -> [EventEntity] {
    let event = EventEntity()
    event.name = "Биатлон"
    event.objectId = 1
    return [event, event, event]
  }
  
  static func eventDays() -> [String] {
    var result: [String] = []
    for day in 23...27 {
      result.append("2017-02-\(day)")
    }
    return result
  }
}
