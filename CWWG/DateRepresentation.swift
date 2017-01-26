//
//  DateRepresentation.swift
//  CWWG
//
//  Created by Alexander Zimin on 26/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation

struct DateRepresentation {
  let date: Date
  var representationString: String = ""
  
  init(date: Date) {
    self.date = date
    
    let now = Date()
    let timeInterval = now.timeIntervalSince(date)
    
    if timeInterval < 0 {
      representationString = Localizations.TimeManagment.Future
    } else {
      let parseFormat = "yyyy-MM-dd-HH-mm"
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = parseFormat
      
      let todayFormat = dateFormatter.string(from: now)
      let dateFormat = dateFormatter.string(from: date)
      
      let todayComponents = todayFormat.components(separatedBy: "-").map({ Int($0) ?? 0 })
      let dateComponents = dateFormat.components(separatedBy: "-").map({ Int($0) ?? 0 })
      
      let todayRepresentation = DateComponentsRepresentation(componentArray: todayComponents)
      let dateRepresentation = DateComponentsRepresentation(componentArray: dateComponents)
      
      let day = dateRepresentation.day
      let month = localized(monthAtIndex: dateRepresentation.month)
      
      let dayDeltaInOneMonth = abs(todayRepresentation.day - dateRepresentation.day)
      let hoursDelta = abs(todayRepresentation.hour - dateRepresentation.hour)
      let minutesDelta = abs(todayRepresentation.minute - dateRepresentation.minute)
      
      let time: String
      if Date.using12hClockFormat {
        dateFormatter.dateFormat = "hh:mm a"
        time = dateFormatter.string(from: date)
      } else {
        time = "\(dateRepresentation.hour):\(dateRepresentation.minute)"
      }
      
      if todayRepresentation.year != dateRepresentation.year {
        representationString = "\(day) \(month), \(dateRepresentation.year)"
      } else if todayRepresentation.month != dateRepresentation.month {
        representationString = "\(day) \(month)"
      } else if dayDeltaInOneMonth > 7 {
        representationString = "\(day) \(month) \(Localizations.TimeManagment.At) \(time)"
      } else if dayDeltaInOneMonth > 1 {
        let dayOfWeek = date.dayOfWeek
        let dayOfWeekString = localized(dayOfWeekAtIndex: dayOfWeek)
        representationString = "\(dayOfWeekString) \(Localizations.TimeManagment.At) \(time)"
      } else if dayDeltaInOneMonth > 0 {
        representationString = Localizations.TimeManagment.Yersteday(value1: time)
      } else if hoursDelta > 0 {
        representationString = "\(Localizations.TimeManagment.Today) \(Localizations.TimeManagment.At) \(time)"
      } else if minutesDelta > 0 {
        representationString = Localizations.TimeManagment.InHour(value1: minutesDelta)
      } else {
        representationString = Localizations.TimeManagment.Now
      }
    }
  }
}

struct DateComponentsRepresentation {
  var year: Int
  var month: Int
  var day: Int
  var hour: Int
  var minute: Int
  
  init(componentArray: [Int]) {
    year = componentArray.safeObject(atIndex: 0) ?? 0
    month = componentArray.safeObject(atIndex: 1) ?? 0
    day = componentArray.safeObject(atIndex: 2) ?? 0
    hour = componentArray.safeObject(atIndex: 3) ?? 0
    minute = componentArray.safeObject(atIndex: 4) ?? 0
  }
}
