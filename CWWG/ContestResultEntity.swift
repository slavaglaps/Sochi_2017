//
//  ContestResultEntity.swift
//  CWWG
//
//  Created by Alexander Zimin on 10/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation
import RealmSwift

class ContestResultEntity: Object {
  dynamic var id: Int = 0
  dynamic var name: String = ""
  dynamic var points: String = ""
  dynamic var place: Int = 0
  dynamic var icon: String = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
