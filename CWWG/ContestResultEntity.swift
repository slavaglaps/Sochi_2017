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
  var id: Int = 0
  var name: String = ""
  var points: String = ""
  var place: Int = 0
  var icon: String = ""
}
