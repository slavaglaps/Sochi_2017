//
//  AppFont.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit.UIFont

struct AppFont {
  
  static func latoBoldFont(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: "Lato-Bold", size: size)!
  }
  
  static func latoBoldItalicFont(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: "Lato-BoldItalic", size: size)!
  }
  
  static func latoItalicFont(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: "Lato-Italic", size: size)!
  }
  
  static func latoLightFont(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: "Lato-Light", size: size)!
  }
  
  static func latoLightItalicFont(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: "Lato-LightItalic", size: size)!
  }
  
  static func latoRegularFont(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: "Lato-Regular", size: size)!
  }
  
}
