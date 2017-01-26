//
//  NewsEntity.swift
//  CWWG
//
//  Created by Alexander Zimin on 25/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation
import RealmSwift

class NewsEntity: Object {
  dynamic var id: Int = 0
  
  dynamic var title: String = ""
  dynamic var text: String?
  dynamic var imageURL: String?
  
  dynamic var dateOfCreation: Date = Date()
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  var isWithImage: Bool {
    guard let imageURL = imageURL else {
      return false
    }
    return !imageURL.isEmpty
  }
  
  var timeString: String {
    return Localizations.News.TimeTitle(value1: 30).uppercased()
  }
}
