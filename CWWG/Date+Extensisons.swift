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
  
  static var using12hClockFormat: Bool {
    let formatter = DateFormatter()
    formatter.locale = Locale.current
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    
    let dateString = formatter.string(from: Date())
    let amRange = dateString.range(of: formatter.amSymbol)
    let pmRange = dateString.range(of: formatter.pmSymbol)
    
    return !(pmRange == nil && amRange == nil)
  }
  
  // Strating from Monday
  var dayOfWeek: Int {
    let dayOfWeekFormat = DateFormatter()
    dayOfWeekFormat.dateFormat = "e"
    let dayOfWeekString = dayOfWeekFormat.string(from: self)
    var dayOfWeek = Int(dayOfWeekString) ?? 1
    
    dayOfWeek -= 1
    if dayOfWeek == 0 {
      dayOfWeek = 7
    }
    
    return dayOfWeek
  }
}
