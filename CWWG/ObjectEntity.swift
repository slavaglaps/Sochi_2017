//
//  ObjectEntity.swift
//  CWWG
//
//  Created by Alexander Zimin on 06/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation
import CoreGraphics
import RealmSwift

class ObjectEntity: Object {
  dynamic var id: Int = 0
  dynamic var title: String = ""
  dynamic var subtitle: String = ""
  dynamic var objectDescription: String = ""
  dynamic var size: Int = 0
  dynamic var imageName: String = ""
  dynamic var event: String = ""
  dynamic var latitude: CGFloat = 0
  dynamic var longitude: CGFloat = 0
}
