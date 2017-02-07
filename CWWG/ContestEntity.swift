//
//  ContestEntity.swift
//  CWWG
//
//  Created by Alexander Zimin on 07/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation
import RealmSwift

class ContestEntity: Object {
  var title: String = ""
  var subtitle: String = ""
  var id: Int = 0
}
