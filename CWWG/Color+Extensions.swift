//
//  Color+Extensions.swift
//  CWWG
//
//  Created by Alexander Zimin on 30/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
  convenience init(hexString: String) {
    var hex = hexString
    
    if hex.hasPrefix("#") {
      hex = hex.substring(from: hex.characters.index(hex.startIndex, offsetBy: 1))
    }
    
    if hex.characters.count == 3 {
      let redHex = hex.substring(to: hex.characters.index(hex.startIndex, offsetBy: 1))
      
      let greenHex = hex.substring(with: Range<String.Index>(hex.characters.index(hex.startIndex, offsetBy: 1)..<hex.characters.index(hex.startIndex, offsetBy: 2)))
      let blueHex = hex.substring(from: hex.characters.index(hex.startIndex, offsetBy: 2))
      
      hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
    }
    
    let redHex = hex.substring(to: hex.characters.index(hex.startIndex, offsetBy: 2))
    let greenHex = hex.substring(with: Range<String.Index>(hex.characters.index(hex.startIndex, offsetBy: 2)..<hex.characters.index(hex.startIndex, offsetBy: 4)))
    let blueHex = hex.substring(with: Range<String.Index>(hex.characters.index(hex.startIndex, offsetBy: 4)..<hex.characters.index(hex.startIndex, offsetBy: 6)))
    
    var redInt:   CUnsignedInt = 0
    var greenInt: CUnsignedInt = 0
    var blueInt:  CUnsignedInt = 0
    
    Scanner(string: redHex).scanHexInt32(&redInt)
    Scanner(string: greenHex).scanHexInt32(&greenInt)
    Scanner(string: blueHex).scanHexInt32(&blueInt)
    
    self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: 1.0)
  }
}
