//
//  EventTypeEntity.swift
//  CWWG
//
//  Created by Alexander Zimin on 07/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit
import RealmSwift

class EventTypeEntity: Object, SelectionEntity {
  dynamic var id: Int = 0
  dynamic var name: String = ""
  let contests = List<ContestEntity>()
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  var color: UIColor {
    switch id {
    case 10...12:
      return AppColor.red
    case 9:
      return AppColor.yellow
    default:
      return AppColor.blue
    }
  }
  
  var imageName: String {
    switch id {
    case 1:
      return "img_sport_2"
    case 3:
      return "img_sport_3"
    case 4:
      return "img_sport_5"
    case 5:
      return "img_sport_4"
    case 6:
      return "img_sport_7"
    case 7:
      return "img_sport_1"
    case 8:
      return "img_sport_6"
    case 9:
      return "img_sport_8"
    default:
      return "img_sport_0"
    }
  }
  
  static func defaultEntity(withId id: Int) -> EventTypeEntity {
    let entity = EventTypeEntity()
    entity.id = id
    return entity
  }
}
