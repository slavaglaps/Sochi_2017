//
//  DAraModelController.swift
//  RealmPlay
//
//  Created by Alexander Zimin on 24/10/15.
//  Copyright © 2015 Alexander Zimin. All rights reserved.
//

import Foundation
import RealmSwift

var defaultRealm: Realm?

class DataModelController {
  static func setup() {
    Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 0, migrationBlock: nil)
    do {
      defaultRealm = try Realm()
    }
    catch {
      assertionFailure("Default realm init error: \(error)")
    }
    
  }
}
