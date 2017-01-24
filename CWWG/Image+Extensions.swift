//
//  Image+Extensions.swift
//  CocoaHeadsApp
//
//  Created by Alex Zimin on 03/10/2016.
//  Copyright © 2016 Cocoa Heads. All rights reserved.
//

import UIKit.UIImage

extension UIImage {
  var imageWithTemplateRendingMode: UIImage {
    return self.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
  }
}

extension UIImage {
  
  class func imageFromColor(_ color: UIColor) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    
    context?.setFillColor(color.cgColor)
    context?.setAlpha(0.5)
    context?.fill(rect);
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
  }
  
  func imageWithColor(_ color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    
    let context = UIGraphicsGetCurrentContext()!
    context.translateBy(x: 0, y: self.size.height)
    context.scaleBy(x: 1.0, y: -1.0);
    context.setBlendMode(CGBlendMode.normal)
    
    let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
    context.clip(to: rect, mask: self.cgImage!)
    color.setFill()
    context.fill(rect)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return newImage
  }
}
