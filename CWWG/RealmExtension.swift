//
//  RealmExtension.swift
//  Hitch
//
//  Created by Alexander Zimin on 14/11/15.
//  Copyright © 2015 Alexander Zimin. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
  public func writeFunction(block: (() -> Void)) {
    if self.isInWriteTransaction {
      block()
    } else {
      do {
        try write(block)
      } catch {
        assertionFailure("Realm write error: \(error)")
      }
    }
  }
}

func writeFunction(realm: Realm? = defaultRealm, block: (() -> Void)) {
  guard let realm = realm else {
    return
  }
  realm.writeFunction(block: block)
}
