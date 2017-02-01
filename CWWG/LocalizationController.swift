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

func localized(monthAtIndex index: Int) -> String {
  if let month = LocalizationController.months.safeObject(atIndex: index - 1) {
    return month
  } else {
    assertionFailure("No such month")
    return ""
  }
}

func localized(dayOfWeekAtIndex index: Int) -> String {
  if let dayOfWeek = LocalizationController.daysOfWeek.safeObject(atIndex: index - 1) {
    return dayOfWeek
  } else {
    assertionFailure("No such day of week")
    return ""
  }
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
  
  private(set) static var months: [String] = []
  private(set) static var daysOfWeek: [String] = []
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
    
    ObjectRuntimeEntityContainer.resetEntities()
    
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
      if row.characters.count == 0 || row.hasPrefix("//") {
        continue
      }
      
      let valuesAtRow = row.components(separatedBy: "\"")
      
      if let key = valuesAtRow.safeObject(atIndex: 1), let value = valuesAtRow.safeObject(atIndex: 3) {
        localizations[key] = value
      } else {
        assertionFailure("Wrong row represintation: \(row)")
      }
    }
    
    months = [Localizations.Time.Month.January,
              Localizations.Time.Month.February,
              Localizations.Time.Month.March,
              Localizations.Time.Month.April,
              Localizations.Time.Month.May,
              Localizations.Time.Month.June,
              Localizations.Time.Month.July,
              Localizations.Time.Month.August,
              Localizations.Time.Month.September,
              Localizations.Time.Month.October,
              Localizations.Time.Month.November,
              Localizations.Time.Month.December]
    
    daysOfWeek = [Localizations.Time.Weekday.Monday,
                  Localizations.Time.Weekday.Tuesday,
                  Localizations.Time.Weekday.Wednesday,
                  Localizations.Time.Weekday.Thursday,
                  Localizations.Time.Weekday.Friday,
                  Localizations.Time.Weekday.Saturday,
                  Localizations.Time.Weekday.Sunday]
  }
  
  // TODO: - Migrate to realm
  
  static var isLocalizationWasSelected: Bool {
    return SettingsEntity.value?.selectedLocalizationString != nil
  }
  
  private(set) static var currentLocalization: Localization {
    set {
      writeFunction {
        SettingsEntity.value?.selectedLocalizationString = newValue.rawValue
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
