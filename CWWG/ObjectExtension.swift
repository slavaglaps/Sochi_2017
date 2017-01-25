//
//  ObjectExtension.swift
//  Juicy Bubble
//
//  Created by Alexander Zimin on 26/10/15.
//  Copyright © 2015 Alexander Zimin. All rights reserved.
//

import Foundation
import RealmSwift

protocol ObjectSingletone: class {
  init()
}

extension ObjectSingletone where Self: Object {
  static var value: Self? {
    guard let realm = defaultRealm else {
      return nil
    }
    
    let object = realm.objects(Self.self).first
    if let value = object {
      return value
    } else {
      let value = Self()
      
      realm.writeFunction(block: { 
         realm.add(value)
      })
      
      return value
    }
  }
}
