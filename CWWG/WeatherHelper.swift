//
//  WeatherHelper.swift
//  CWWG
//
//  Created by Alexander Zimin on 07/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

struct WeatherHelper {
  static func parseWeatherId(id: Int) -> UIImage {
    
    let idString = "\(id)"
    if idString == "800" {
      return #imageLiteral(resourceName: "img_weather_800")
    }
    
    if idString == "801" {
      return #imageLiteral(resourceName: "img_weather_801")
    }
    
    if idString.hasPrefix("8") {
      return #imageLiteral(resourceName: "img_weather_8xx")
    }
    
    if idString.hasPrefix("2"){
      return #imageLiteral(resourceName: "img_weather_2xx")
    }
    
    if idString.hasPrefix("3"){
      return #imageLiteral(resourceName: "img_weather_3xx")
    }
    
    if idString.hasPrefix("5"){
      return #imageLiteral(resourceName: "img_weather_5xx")
    }
    
    if idString.hasPrefix("6"){
      return #imageLiteral(resourceName: "img_weather_6xx")
    }
    
    return #imageLiteral(resourceName: "img_weather_8xx")
  }
}
