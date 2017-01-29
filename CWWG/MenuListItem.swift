//
//  MenuListItem.swift
//  CWWG
//
//  Created by Alexander Zimin on 29/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation

enum MenuListItem {
  case news
  case schedule
  case objects
  case results
  case broadcast
  case accreditation
  case quiz
  
  var title: String {
    switch self {
    case .news:
      return Localizations.MenuItem.News
    case .schedule:
      return Localizations.MenuItem.Schedule
    case .objects:
      return Localizations.MenuItem.Objects
    case .results:
      return Localizations.MenuItem.Results
    case .broadcast:
      return Localizations.MenuItem.Broadcast
    case .accreditation:
      return Localizations.MenuItem.Accreditation
    case .quiz:
      return Localizations.MenuItem.Quiz
    }
  }
}