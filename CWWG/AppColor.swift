//
//  AppColor.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit.UIColor

struct AppColor {
  
  static var clear: UIColor {
    return UIColor.clear
  }
  
  static var white: UIColor {
    return UIColor.white
  }
  
  static var black: UIColor {
    return UIColor.black
  }
  
  static var gray: UIColor {
    return AppColor.black.withAlphaComponent(0.5)
  }
  
  static var seperatorColor: UIColor {
    return UIColor.black.withAlphaComponent(0.1)
  }
  
  static var emptyHeaderBlue: UIColor {
    return UIColor(red: 30.0 / 255.0, green: 95.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0)
  }
  
  static var titleColor: UIColor {
    return UIColor(red: 62.0 / 255.0, green: 81.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0)
  }
  
  static var navigationBarTintColor: UIColor {
    return UIColor(red: 177.0 / 255.0, green: 185.0 / 255.0, blue: 191.0 / 255.0, alpha: 1.0)
  }
}
