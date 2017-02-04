//
//  UIView+Extensions.swift
//  CWWG
//
//  Created by Alexander Zimin on 04/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

internal extension UIView {
  class func az_viewFromNib() -> Self {
    return self.az_viewFromNib(withOwner: nil)
  }
  
  class func az_viewFromNib(withOwner owner: Any?) -> Self {
    let name = NSStringFromClass(self as! AnyClass).components(separatedBy: ".").last!
    let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: owner, options: nil).first!
    // assert((view is self), nil)
    return cast(view)!
  }
  
  func az_loadFromNibIfEmbeddedInDifferentNib() -> Self {
    // based on: http://blog.yangmeyer.de/blog/2012/07/09/an-update-on-nested-nib-loading
    let isJustAPlaceholder = self.subviews.count == 0
    if isJustAPlaceholder {
      let theRealThing = type(of: self).az_viewFromNib(withOwner: nil)
      theRealThing.frame = self.frame
      self.translatesAutoresizingMaskIntoConstraints = false
      theRealThing.translatesAutoresizingMaskIntoConstraints = false
      return theRealThing
    }
    return self
  }
}

private func cast<T, U>(_ value: T) -> U? {
  return value as? U
}
