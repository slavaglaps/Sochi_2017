//
//  LocalizationController.swift
//  CWWG
//
//  Created by Alexander Zimin on 25/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation

// cd $BASE_PATH/CWWG/Localization
// swift LaurineGenerator.swift -i en-EN.txt -c -o Localizations.swift

func localized(string: String, comment: String = "") -> String {
  return LocalizationController.localized(string: string, comment: comment)
}

func localized(string: String, tableName: String?, bundle: Bundle, value: String, comment: String = "") -> String {
  return LocalizationController.localized(string: string, comment: comment)
}

struct LocalizationController {
  
  enum Localization: String {
    case russian = "ru-RU"
    case english = "en-EN"
  }
  
  static func loadLocalization() {
    loadLocalizationInMemory(localization: .english)
  }
  
  private static var localizations: [String: String] = [:]
  
  static func localized(string: String, comment: String = "") -> String {
    if let string = localizations[string] {
      return string
    }
    assertionFailure("No such localization string: \(string)")
    return ""
  }
  
  static func change(localization: Localization) {
    loadLocalizationInMemory(localization: localization)
    NotificationCenter.default.postUpdateUINotification()
  }
  
  private static func loadLocalizationInMemory(localization: Localization) {
    let filePath = Bundle.main.path(forResource: localization.rawValue, ofType: "txt") ?? ""
    var result = ""
    
    do {
      result = try String(contentsOfFile: filePath)
    }
    catch {
      print(error)
      assertionFailure("No such localization file: \(filePath)")
      return
    }
    
    localizations = [:]
    let rows = result.components(separatedBy: "\n")
    for row in rows {
      if row.characters.count == 0 {
        continue
      }
      
      let valuesAtRow = row.components(separatedBy: "\"")
      
      if let key = valuesAtRow.safeObject(atIndex: 1), let value = valuesAtRow.safeObject(atIndex: 3) {
        localizations[key] = value
      } else {
        assertionFailure("Wrong row represintation: \(row)")
      }
    }
  }
}
