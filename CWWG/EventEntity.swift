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
  dynamic var isEvent: Bool = false
  dynamic var name: String = ""
  dynamic var dayString: String = ""
  
  var image: UIImage {
    return UIImage(named: "img_sport_1")!
  }
  
  var timeIntervalString: String {
    return "11:00 - 14:00"
  }
  
  static func fakeData() -> [EventEntity] {
    let event = EventEntity()
    event.name = "Биатлон"
    event.objectId = 1
    return [event, event, event]
  }
}
