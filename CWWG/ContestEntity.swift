//
//  ContestEntity.swift
//  CWWG
//
//  Created by Alexander Zimin on 07/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation
import RealmSwift

class ContestEntity: Object, SelectionEntity {
  dynamic var name: String = ""
  dynamic var id: Int = 0
  let eventType = LinkingObjects(fromType: EventTypeEntity.self, property: "contests")
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
