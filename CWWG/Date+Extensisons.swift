//
//  Date+Extensisons.swift
//  CWWG
//
//  Created by Alexander Zimin on 26/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation

extension Date {
  init?(serverString: String) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
    if let date = dateFormatter.date(from: serverString) {
      self = date
    } else {
      return nil
    }
  }
}
