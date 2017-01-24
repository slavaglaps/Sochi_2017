//
//  LocalizationController.swift
//  CWWG
//
//  Created by Alexander Zimin on 25/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation

func localizedString(string: String, comment: String = "") -> String {
  return LocalizationController.localizedString(string: string, comment: comment)
}

struct LocalizationController {
  static func localizedString(string: String, comment: String = "") -> String {
    return ""
  }
}
