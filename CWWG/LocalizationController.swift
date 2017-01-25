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
    
    var serverString: String {
      switch self {
      case .russian:
        return "ru"
      case .english:
        return "en"
      }
    }
  }
  
  static func loadLocalization() {
    loadLocalizationInMemory(localization: currentLocalization)
  }
  
  private static var localizations: [String: String] = [:]
  
  static func localized(string: String, comment: String = "") -> String {
    if let string = localizations[string] {
      return string
    }
    assertionFailure("No such localization string: \(string)")
    return ""
  }
  
  static func select(localization: Localization) {
    currentLocalization = localization
    loadLocalizationInMemory(localization: localization)
    NotificationCenter.default.postUpdateLanguageChangedNotification()
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
  
  // TODO: - Migrate to realm
  
  static var isLocalizationWasSelected: Bool {
    return SettingsEntity.value?.selectedLocalizationString != nil
  }
  
  private(set) static var currentLocalization: Localization {
    set {
      writeFunction { 
        SettingsEntity.value?.selectedLocalizationString = currentLocalization.rawValue
      }
    }
    get {
      let currentLocalization = SettingsEntity.value?.selectedLocalizationString
      if let currentLocalizationString = currentLocalization, let localization = Localization(rawValue: currentLocalizationString) {
        return localization
      }
      
      let deviceLocalizationString = NSLocalizedString("localization-tag", comment: "")
      if let deviceLocalization = Localization(rawValue: deviceLocalizationString) {
        return deviceLocalization
      }
      
      return .english
    }
  }
}
